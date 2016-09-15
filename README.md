run it like this:

docker run -it --rm -v ~/.:/root/workStation yoyo/docker-vim-tiny vim

you can set a alias:

alias vv='docker run -it --rm -v $(pwd):/root/workStation yoyo/docker-vim-tin
