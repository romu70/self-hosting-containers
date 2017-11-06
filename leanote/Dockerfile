# ------------------------------------------------------------------------------
# Based on a work at https://github.com/docker/docker.
# ------------------------------------------------------------------------------
# Pull base image.
FROM ubuntu:16.04
MAINTAINER R. Tisserand <r@tisserand.eu>

# ------------------------------------------------------------------------------
# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN echo "Europe/Paris" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

ENV GOPATH /app

# ------------------------------------------------------------------------------
RUN apt-get update -qq
RUN apt-get install debconf-utils
RUN apt-get install -yq curl
RUN apt-get clean

# ------------------------------------------------------------------------------
# Install Leanote
RUN curl -L https://sourceforge.net/projects/leanote-bin/files/2.4.5/leanote-linux-amd64-v2.4.5.bin.tar.gz/download >> /tmp/leanote.tar.gz
RUN mkdir -p /src  /app/src/github.com/leanote \
    && tar -xzvf /tmp/leanote.tar.gz -C /src \
    && ln -s /src/leanote/bin/src/github.com/revel /app/src/github.com/revel \
    && ln -s /src/leanote /app/src/github.com/leanote/leanote \
    && ln -s /src/leanote/bin/leanote-linux-amd64 /app/leanote-linux-amd64 \
    && rm /tmp/leanote.tar.gz
RUN chmod +x /app/src/github.com/leanote/leanote/bin/run.sh

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 9000

# ------------------------------------------------------------------------------
WORKDIR  /app
#WORKDIR  /app/src/github.com/leanote/leanote/bin

CMD ["/app/leanote-linux-amd64","-importPath","github.com/leanote/leanote"]
#ENTRYPOINT ["sh", "run.sh"]

