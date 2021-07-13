FROM ubuntu:focal-20210609 as base
# hadolint ignore=SC1072,DL3008,DL4006
RUN apt-get update && \
  apt-get install -y --no-install-recommends gnupg2 curl ca-certificates apt-transport-https openssh-client && \
  echo 'deb http://ppa.launchpad.net/git-core/ppa/ubuntu focal main' > /etc/apt/sources.list.d/git.list && \
  echo 'deb https://packagecloud.io/github/git-lfs/ubuntu/ focal main' > /etc/apt/git-lfs.list && \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
  curl -fsSL https://packagecloud.io/github/git-lfs/gpgkey | gpg --dearmor -o /usr/share/keyrings/github-git-lfs-6B05F25D762E3157.gpg && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DD270288B4E6030699E45FA1715D88E1DF1F24 && \
  echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  focal stable" | tee /etc/apt/sources.list.d/docker.list && \
  apt-get update &&  \
  apt-get install -y --no-install-recommends git git-lfs zsh docker-ce-cli && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
# hadolint ignore=DL3022
COPY --from=hadolint/hadolint:2.6.0 /bin/hadolint /usr/bin/

ARG UID=1000
ARG GUID=1000
ARG DOCKER_GUID=1001

FROM base as base-shell
# hadolint ignore=SC2086
RUN groupadd -g ${DOCKER_GUID} docker && \ 
  groupadd -g ${GUID} vscode && \
  useradd -ms /bin/zsh -l -G docker -u ${UID} -g ${GUID} vscode
USER vscode
# hadolint ignore=SC2086
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
  git clone --depth=1 https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
COPY .zshrc /home/vscode/.zshrc
CMD ["bash", "-c", "while true; do echo hello; sleep 2; done" ]