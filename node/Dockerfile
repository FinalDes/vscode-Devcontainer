# syntax=docker/dockerfile:1.3
FROM finaldes/vscode-devcontainer:base as node-base
ARG NODE_VERSION=16
ENV DEBIAN_FRONTEND=noninteractive
# hadolint ignore=DL3008,DL4006,DL3015
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor -o /usr/share/keyrings//nodesource.gpg  && \
  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/yarnkey.gpg && \
  echo "deb [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_VERSION}.x focal main" > /etc/apt/sources.list.d/nodejs.list && \
  echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" > /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -y build-essential nodejs yarn && \
  apt-get clean && \
  npm -g install eslint nodemon typescript @angular/cli @graphql-codegen/cli webpack-bundle-analyzer && \
  rm -rf /var/lib/apt/lists/