run it like this:

docker run -it --rm -v ~/.:/root/workStation que01/docker-vim-tiny vim

you can set a alias:

alias vv='docker run -it --rm -v $(pwd):/root/workStation que01/docker-vim-tin
