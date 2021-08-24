# Container to host the Lithium SDK (for Khoros communities)
# Other flavors/versions of Linux might be supported, but 
# Centos is what I've used and tested.
FROM centos:7
USER root
LABEL maintainer="chris.hemedinger@sas.com"
LABEL org.label-schema.docker.cmd="docker run -u sdkuser --name khoros_sdk -it --rm --volume 'C:\Projects\khoros-sdk\plugins:/home/sdkuser/plugins' cjdinger/khoros-sdk:1.0"

# Update the image with the latest packages (recommended)
RUN yum update -y; yum clean all

# these base tools are needed to fetch and build local SDK pieces
RUN yum -y install rsync
RUN yum -y install git
RUN yum -y install bzip2

# this might get more than needed, but we need the make tool and c/c++ compiler
RUN yum -y groupinstall "Development Tools"

# this backlevel version of nodejs is supported in the SDK
RUN curl -sL https://rpm.nodesource.com/setup_8.x | bash -

RUN yum install -y nodejs

# create a local user in the container, will mount a volume
# in docker run command to host SDK plugins
RUN useradd -ms /bin/bash sdkuser
USER sdkuser
WORKDIR /home/sdkuser

# set a location to install these node apps
RUN mkdir /home/sdkuser/.npm-global
ENV NPM_CONFIG_PREFIX=/home/sdkuser/.npm-global

RUN npm install gulp -g

# see developer.khoros.com for help with the plugin SDK
RUN npm install lithium-sdk -g

# add path so "li" command will work in shell
ENV PATH "$PATH:/home/sdkuser/.npm-global/bin"


