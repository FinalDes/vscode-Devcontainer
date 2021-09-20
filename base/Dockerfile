# syntax = docker/dockerfile:1.3.0
FROM ubuntu:focal-20210827 as base
ENV ZSH=/home/vscode/.oh-my-zsh
COPY --chown=root:root init.sh /usr/local/share/ 
# hadolint ignore==SC1072,DL3008,DL4006
COPY --from=hadolint/hadolint:2.7.0 /bin/hadolint /usr/bin/
RUN set -eux;\
	apt-get update; \
	apt-get install -y gosu apt-transport-https ca-certificates curl gnupg openssh-client locales socat; \
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
  useradd -ms /bin/zsh vscode;
# hadolint ignore=SC2086
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; \
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH}/plugins/zsh-syntax-highlighting; \
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH}/custom/plugins/zsh-autosuggestions; \
  git clone --depth=1 https://github.com/zsh-users/zsh-completions ${ZSH}/custom/plugins/zsh-completions; \
  chown -R vscode:vscode ${ZSH}
ENTRYPOINT [ "/usr/local/share/init.sh" ]