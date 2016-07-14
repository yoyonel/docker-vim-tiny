FROM alpine

MAINTAINER que01 <que01@foxmail.com>


RUN apk --update add curl ctags git python bash ncurses-terminfo nodejs zsh vim                        && \
apk add --virtual build-deps llvm perl cmake python-dev build-base                                     && \
git clone https://github.com/que01/vimrc ~/.vim_runtime && cd ~/.vim_runtime                           && \
sh install_awesome_vimrc.sh && git submodule init && git submodule update                              && \
cd ~/.vim_runtime/sources_non_forked/YouCompleteMe && git submodule update --init --recursive          && \
./install.py  && cd ~/.vim_runtime && find . -name ".git" | xargs rm -Rf                               && \
cd ~/.vim_runtime/sources_non_forked/tern_for_vim && npm install                                       && \
apk del build-deps                                                                                     && \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
mkdir ~/workStation && cd ~/workStation

# Default to a login shell
CMD ["vim"]
