# Dockerfile for development machine

# Select Ubuntu as the base image
FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive

# Install build tools
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    wget \
    autoconf \
    bison \
    libssl-dev \
    libyaml-dev \
    libreadline6-dev \
    zlib1g-dev \
    libncurses5-dev \
    libffi-dev \
    libgdbm3 \
    libgdbm-dev \
    ruby-dev \
    libbz2-dev \
    libsqlite3-dev

# Install and configure rbenv
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv && \
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build && \
  git clone https://github.com/sstephenson/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars && \
  . ~/.bashrc && \
  rbenv install 2.2.3 && \
  rbenv rehash && \
  rbenv global 2.2.3 && \
  gem update --system && \
  gem install pry pry-doc rails

# Install Nodenv
RUN git clone https://github.com/OiNutter/nodenv.git ~/.nodenv && \
  echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.bashrc && \
  echo 'eval "$(nodenv init -)"' >> ~/.bashrc && \
  mkdir ~/.nodenv/plugins && \
  git clone git://github.com/OiNutter/node-build.git ~/.nodenv/plugins/node-build && \
  git clone https://github.com/OiNutter/nodenv-vars.git ~/.nodenv/plugins/nodenv-vars && \
  . ~/.bashrc && \
  nodenv install 0.12.4 && \
  nodenv rehash && \
  nodenv global 0.12.4

# Startup commands
ENTRYPOINT /bin/bash

