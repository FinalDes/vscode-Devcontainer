# syntax = docker/dockerfile:1.3.0
FROM ubuntu:focal-20211006 as base
ENV COMPOSE_V1_VERSION=1.29.2
ARG COMPOSE_V2_VERSION=v2.0.1
ARG USERNAME=vscode
ENV ZSH=/home/vscode/.oh-my-zsh
COPY --chmod=755 --chown=root:root init2.sh /usr/local/bin/ 
# hadolint ignore=DL3022
COPY --from=hadolint/hadolint:2.7.0 /bin/hadolint /usr/bin/
# hadolint ignore=DL3008,DL3015,DL4006
RUN set -eux;\
	apt-get update; \
	apt-get install -y sudo apt-transport-https ca-certificates curl gnupg openssh-client locales socat; \
  sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
  dpkg-reconfigure --frontend=noninteractive locales; \
  update-locale LANG=en_US.UTF-8; \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DD270288B4E6030699E45FA1715D88E1DF1F24; \
  curl -fsSL https://packagecloud.io/github/git-lfs/gpgkey | gpg --dearmor -o /usr/share/keyrings/github-git-lfs-6B05F25D762E3157.gpg; \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg; \
  echo 'deb http://ppa.launchpad.net/git-core/ppa/ubuntu focal main' > /etc/apt/sources.list.d/git.list; \
  echo 'deb https://packagecloud.io/github/git-lfs/ubuntu/ focal main' > /etc/apt/git-lfs.list; \ 
  echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  focal stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null; \
  apt-get update; \
  apt-get install -y git git-lfs zsh docker-ce-cli; \
	rm -rf /var/lib/apt/lists/*; \
  useradd -ms /bin/zsh ${USERNAME}; \
  echo 'vscode    ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/vscode; \ 
  chmod 600 /etc/sudoers.d/vscode; \
  mkdir -p /home/vscode/.docker/cli-plugins/; \
  curl -SL "https://github.com/docker/compose/releases/download/${COMPOSE_V2_VERSION}/docker-compose-linux-x86_64" -o /home/vscode/.docker/cli-plugins/docker-compose; \ 
  curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_V1_VERSION}/docker-compose-Linux-x86_64" -o /usr/local/bin/docker-compose; \
  chown -R vscode:vscode /home/vscode/.docker; \ 
  chmod 755 /home/vscode/.docker/cli-plugins/docker-compose; \
  chmod +x /usr/local/bin/docker-compose; \
  mkdir /home/${USERNAME}/.vscode-server/ \ 
    /home/${USERNAME}/.vscode-server/extensions \
    /home/${USERNAME}/.vscode-server-insiders/ \
    /home/${USERNAME}/.vscode-server-insiders/extensions; \
  chown -R ${USERNAME} \
        /home/${USERNAME}/.vscode-server \
        /home/${USERNAME}/.vscode-server-insiders;
# hadolint ignore=SC2086
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; \
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH}/plugins/zsh-syntax-highlighting; \
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH}/custom/plugins/zsh-autosuggestions; \
  git clone --depth=1 https://github.com/zsh-users/zsh-completions ${ZSH}/custom/plugins/zsh-completions; \
  chown -R ${USERNAME}:${USERNAME} ${ZSH}
COPY --chown=${USERNAME}:${USERNAME} .zshrc /home/${USERNAME}/
# ENTRYPOINT [ "/usr/local/bin/init2.sh" ]
# CMD [ "sleep", "infinity" ]