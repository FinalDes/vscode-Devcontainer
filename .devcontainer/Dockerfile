# syntax=docker/dockerfile:1.3
FROM finaldes/vscode-devcontainer:base as base-shell
ARG UID=1000
ARG GUID=1000
ARG DOCKER_GUID=1001
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