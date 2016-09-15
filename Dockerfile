FROM alpine:latest

# définition du proxy
#ENV http_proxy http://proxy.ign.fr:3128
#ENV https_proxy http://proxy.ign.fr:3128
#ENV HTTP_PROXY http://proxy.ign.fr:3128

MAINTAINER yoyonel <yoyonel@hotmail.com>

ENV TERM=xterm-256color

RUN apk --update add zsh python python-dev nodejs zsh ctags git ncurses-terminfo curl \
    libsm libice libxt libx11 ncurses                                                 && \
    apk add --update --virtual build-deps  build-base make mercurial libxpm-dev \
        libx11-dev libxt-dev ncurses-dev   bash llvm perl cmake                       && \
    cd /tmp                                                                           && \
    git clone https://github.com/vim/vim

# Configuration et compilation de Vim
RUN cd /tmp/vim                                                                       && \
    ./configure --with-features=big \
                #needed for editing text in languages which have many characters
                --enable-multibyte \
                #python interop needed for some of my plugins
                --enable-pythoninterp \
                --with-python-config-dir=/usr/lib/python2.7/config \
                --disable-gui \
                --disable-netbeans \
                --prefix /usr                                                   && \
    make VIMRUNTIMEDIR=/usr/share/vim/vim80 -j                                  && \
    make install -j                                                             && \
    #deleting docs, tutorials, icons and lang
    rm -rf /usr/share/man/* /usr/share/icons/* /usr/share/doc/* /tmp/* \
      /var/cache/* /var/log/* /var/tmp/*                                       && \
    mkdir /var/cache/apk                                                       

#
RUN cd /usr/share/vim/vim80/                                                   && \
    rm -rf lang/* tutor/* gvimrc_example.vim vimrc_example.vim                 && \
    find . -name *.txt                                                         && \
    git clone https://github.com/yoyonel/vimrc.git ~/.vim_runtime && cd ~/.vim_runtime                     && \
    sh install_awesome_vimrc.sh && git submodule init && git submodule update                              

RUN 	cd ~/.vim_runtime/sources_non_forked/YouCompleteMe 				&&\
	git submodule update --init --recursive						&&\
	./install.py  && cd ~/.vim_runtime && find . -name ".git" | xargs rm -Rf

RUN 	cd ~/.vim_runtime/sources_non_forked/YouCompleteMe 				&&\
	./install.py --clang-completer

#RUN cd ~/.vim_runtime/sources_non_forked/tern_for_vim && npm install                                       && \
#cd ~/.vim_runtime/sources_non_forked/vimproc && make                                                   && \
#npm install -g jsctags                                                                                 && \
#apk del build-deps                                                                                     && \

#RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh                                     && \
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh 				&& \
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

#RUN rm -rf /var/cache/apk/* \
#    && find / -type f -iname \*.apk-new -delete \
#    && rm -rf /var/cache/apk/*

# Define working directory.
WORKDIR /root/workStation

ENV VIMRUNTIMEDIR /usr/share/vim/vim80
