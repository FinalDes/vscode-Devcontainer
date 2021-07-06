FROM ubuntu:focal-20210609 as base
# hadolint ignore=SC1072
RUN apt-get update && \
  apt-get install -y --no-install-recommends gnupg2 curl ca-certificates apt-transport-https && \
  echo 'deb http://ppa.launchpad.net/git-core/ppa/ubuntu focal main' > /etc/apt/sources.list.d/git.list && \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DD270288B4E6030699E45FA1715D88E1DF1F24 && \
  echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  focal stable" | tee /etc/apt/sources.list.d/docker.list && \
  apt-get update &&  \
  apt-get install -y --no-install-recommends git zsh docker-ce-cli && \
  useradd -ms /bin/zsh vscode && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
# hadolint ignore=DL3022
COPY --from=hadolint/hadolint:2.6.0 /bin/hadolint /usr/bin/

FROM base as base-shell
USER vscode
# hadolint ignore=SC2086
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
  git clone --depth=1 https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
COPY .zshrc /home/vscode/.zshrc
CMD ["bash", "-c", "while true; do echo hello; sleep 2; done" ]