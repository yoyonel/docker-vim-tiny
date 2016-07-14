FROM alpine

MAINTAINER que01 <que01@foxmail.com>

RUN apk --update add curl ctags git python bash ncurses-terminfo nodejs zsh                            && \
apk add --virtual build-deps llvm perl cmake python-dev build-base                                     && \
git clone https://github.com/que01/vimrc ~/.vim_runtime && cd ~/.vim_runtime                           && \
sh install_awesome_vimrc.sh && git submodule init && git submodule update                              && \
cd ~/.vim_runtime/sources_non_forked/YouCompleteMe && git submodule update --init --recursive          && \
./install.py  && cd ~/.vim_runtime && find . -name ".git" | xargs rm -Rf                               && \
cd ~/.vim_runtime/sources_non_forked/tern_for_vim && npm install                                       && \
apk del build-deps                                                                                     && \
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh                                     && \
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc                                                  && \
mkdir ~/workStation && cd ~/workStation                                                                && \
rm -rf /var/cache/apk/* \
    && find / -type f -iname \*.apk-new -delete \
    && rm -rf /var/cache/apk/*

# Define working directory.
WORKDIR ~/workStation
