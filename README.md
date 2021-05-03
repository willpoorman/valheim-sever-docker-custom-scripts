# valheim-sever-docker-custom-scripts
Custom scripts for use with [lloesche/valheim-server-docker](https://github.com/lloesche/valheim-server-docker)

## Getting Started

I am running the container as a systemd service using
[these instructions](https://github.com/lloesche/valheim-server-docker#deploying-with-docker-and-systemd).
If you are too, you can follow these instructions exactly. Otherwise you'll
need to adjust them to fit your deployment style:

1. Copy `valheim-server.env` to `/etc/sysconfig/valheim-server` and fill in the
empty env variables with the appropriate values for your setup. For the scripts
that send messages to a Discord webhook, you'll need to first generate the
webhook for the channel you want it to post in, before you can provide it to
that env variable. Ensure the env file is owned by root and the root user has
at least read access to the file:
  1. `sudo chown root:root /etc/sysconfig/valheim-server`
  2. `sudo chmod +r /etc/sysconfig/valheim-server`
2. Copy the `scripts` directory into `/etc/valheim/config/`. Ensure the dir and
all files in it are owned by root, the root user has read access to the dir,
and execute access for the scripts in the dir:
  1. `sudo chown root:root /etc/valheim/config`
  2. `sudo chmod +r /etc/valheim/config/scripts`
  3. `sudo chmod +x /etc/valheim/config/scripts/*`
3. Shut down the server systemd service if its running:
`sudo systemctl stop valheim.service`
4. Confirm that the container was deleted, not just stopped. It needs to be
deleted so that when we start the service again, it will be recreated with the
new env variables and values. Before deleting it, ensure you have some way to
still access the world data, hopefully by having it stored in a dir that you
mount as a volume to the container, instead of storing directly in the
container (Instructions not provided, outside of the scope of this project)
  1. `docker container ls --all`. If you see the `valheim.service` container
listed, it was not deleted, run step 2. Otherwise move on.
  2. `docker container rm valheim.service`
5. Start the service back up: `sudo systemctl start valheim.service`
