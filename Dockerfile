FROM jare/vim-wrapper:latest

MAINTAINER JAremko <que01@foxmail.com>

#Plugins deps
RUN apk --update add nodejs curl ctags git python bash ncurses-terminfo　　　　　　　　　                          && \
git clone https://github.com/que01/vimrc /root/.vim_runtime && cd /root/.vim_runtime 　                         && \
sh install_awesome_vimrc.sh && git submodule init && git submodule update                                       && \
#Build YouCompleteMe
    cd /root/.vim_runtime/sources_non_forked/YouCompleteMe && git submodule update --init --recursive           && \
    apk add --virtual build-deps go llvm perl cmake python-dev build-base                                       && \
    cd /root/.vim_runtime/sources_non_forked/YouCompleteMe && git submodule update --init --recursive           && \
    /root/.vim_runtime/sources_non_forked/YouCompleteMe/install.py --tern-completer                             && \
    make                                                                                                        && \
#Cleanup
    rm -rf /root/.vim_runtime/sources_non_forked/YouCompleteMe/third_party/ycmd/cpp   \
      /root/.vim_runtime/sources_non_forked/YouCompleteMe/third_party/ycmd/clang_includes                       && \
    apk del build-deps && cd ~/.vim_runtime && find . -name ".git" | xargs rm -Rf                               && \
    apk add libxt libx11 libstdc++                                                                              && \
    sh /util/ocd-clean / > /dev/null 2>&1
