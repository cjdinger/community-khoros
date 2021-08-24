# Working with the Khoros Community Plugin SDK

The Khoros community platform (formerly Lithium) supports an "SDK" method for maintaining community components and styles. This allows you to manage your community "source code" as a developer. This Docker image contains everything you need to support the SDK development environment.

Docker image available for **docker pull** on [Docker Hub as cjdinger/khoros-sdk](https://hub.docker.com/repository/docker/cjdinger/khoros-sdk/).

Full documentation about the community plugin SDK is at [https://developer.khoros.com/](https://developer.khoros.com/) (sign-in as a Khoros customer may be required).

## Software in this image

- Centos 7 baseline OS
- Installer tools: rsync, git, bzip2
- Developer tools needed to build components during install (C/C++ compilers and make tool)
- NodeJS v8 (backlevel, but that's how I got this working)
- npm gulp tool
- lithium-sdk v1.9

The container also creates a single user: sdkuser. This account is used within the container to run the *li* commands in the shell as you update and build the plugin.

## How to use

In your local host, create a directory to store your community plugins. We'll mount this directory as a volume as part of the *docker run* command.

After *docker pull*, run the image with a command like:

     docker run -u sdkuser --name khoros_sdk -it --rm --volume 'C:\Projects\khoros-sdk\plugins:/home/sdkuser/plugins' cjdinger/khoros-sdk:1.0

The command will put you into a shell as **sdkuser**, where you can then access the ./plugins directory as your home base for managing your community plugins.