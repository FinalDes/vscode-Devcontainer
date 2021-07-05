FROM ubuntu:focal-20210609
RUN apt update && \
  apt install -y gnupg2 && \
  echo 'deb http://ppa.launchpad.net/git-core/ppa/ubuntu focal main ' > /etc/apt/sources.list.d/git.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DD270288B4E6030699E45FA1715D88E1DF1F24 && \
  apt update &&  \
  apt install -y curl git zsh && \
  useradd -ms /bin/zsh vscode
USER vscode
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
  git clone --depth=1 https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
COPY .zshrc /home/vscode/.zshrc
CMD ["bash", "-c", "while true; do echo hello; sleep 2; done" ]