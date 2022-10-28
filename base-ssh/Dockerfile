# syntax = docker/dockerfile:1.3.0
FROM ubuntu:jammy-20221003 as base
# ENV COMPOSE_V1_VERSION=1.29.2
# ARG COMPOSE_V2_VERSION=2.5.1
ARG ACTION_LINT_VERSION=1.6.21
ARG USERNAME=vscode
# ENV ZSH=/home/vscode/.oh-my-zsh
# COPY --chmod=755 --chown=root:root init2.sh /usr/local/bin/ 

# hadolint ignore=DL3022
COPY --chmod=755 --chown=root:root init.sh /usr/local/bin/ 
COPY --from=hadolint/hadolint:2.10.0 /bin/hadolint /usr/bin/
# hadolint ignore=DL3008,DL3015,DL4006
RUN set -eux;\
	apt-get update; \
	apt-get install -y sudo apt-transport-https ca-certificates curl gnupg openssh-client openssh-server locales passwd; \
  sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
  dpkg-reconfigure --frontend=noninteractive locales; \
  update-locale LANG=en_US.UTF-8; \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DD270288B4E6030699E45FA1715D88E1DF1F24; \
  curl -fsSL https://packagecloud.io/github/git-lfs/gpgkey | gpg --dearmor -o /usr/share/keyrings/github-git-lfs-6B05F25D762E3157.gpg; \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg; \
  echo 'deb http://ppa.launchpad.net/git-core/ppa/ubuntu focal main' > /etc/apt/sources.list.d/git.list; \
  echo 'deb https://packagecloud.io/github/git-lfs/ubuntu/ focal main' > /etc/apt/git-lfs.list; \ 
  apt-get update; \
  apt-get install -y git git-lfs; \
	rm -rf /var/lib/apt/lists/*; \
  useradd -m ${USERNAME}; \
  echo "${USERNAME}:${USERNAME}" | chpasswd; \
  echo "${USERNAME}    ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vscode; \ 
  chmod 600 /etc/sudoers.d/vscode; \
  curl -L https://github.com/rhysd/actionlint/releases/download/v${ACTION_LINT_VERSION}/actionlint_${ACTION_LINT_VERSION}_linux_amd64.tar.gz | tar xvz actionlint; \
  chmod 755 actionlint; \
  mv actionlint /usr/local/bin/; \
  mkdir /home/${USERNAME}/.vscode-server/ \ 
    /home/${USERNAME}/.vscode-server/extensions \
    /home/${USERNAME}/.vscode-server-insiders/ \
    /home/${USERNAME}/.vscode-server-insiders/extensions; \
  chown -R ${USERNAME} \
        /home/${USERNAME}/.vscode-server \
        /home/${USERNAME}/.vscode-server-insiders;
  # service ssh start;
EXPOSE 22
# CMD [" service", "ssh", "start"]
# CMD ["/usr/sbin/sshd","-D"]
ENTRYPOINT [ "/usr/local/bin/init.sh" ]
CMD [ "sleep", "infinity" ]