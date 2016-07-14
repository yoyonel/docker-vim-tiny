FROM alpine

MAINTAINER que01 <que01@foxmail.com>


RUN apk --update add zsh python python-dev nodejs zsh ctags git ncurses-terminfo curl \
    libsm libice libxt libx11 ncurses                                                 && \
    apk add --update --virtual build-deps  build-base make mercurial libxpm-dev \
        libx11-dev libxt-dev ncurses-dev   bash llvm perl cmake                       && \
    cd /tmp                                                                           && \
    git clone https://github.com/vim/vim                                              && \
    cd /tmp/vim                                                                       && \
    ./configure --with-features=big \
                #needed for editing text in languages which have many characters
                --enable-multibyte \
                #python interop needed for some of my plugins
                --enable-pythoninterp \
                --with-python-config-dir=/usr/lib/python2.7/config \
                --disable-gui \
                --disable-netbeans \
                --prefix /usr                                                   && \
    make VIMRUNTIMEDIR=/usr/share/vim/vim74                                     && \
    make install                                                                && \
    #deleting docs, tutorials, icons and lang
    rm -rf /usr/share/man/* /usr/share/icons/* /usr/share/doc/* /tmp/* \
      /var/cache/* /var/log/* /var/tmp/*                                       && \
    mkdir /var/cache/apk                                                       && \
    cd /usr/share/vim/vim74/                                                   && \
    rm -rf lang/* tutor/* gvimrc_example.vim vimrc_example.vim                 && \
    find . -name *.txt                                                         && \
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
