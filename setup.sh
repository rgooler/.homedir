#!/bin/bash
#Setup subrepos
git submodule init
git submodule update

shopt -s dotglob
cd ~

for f in $OLDPWD/*; do
    O="$(basename $f)"
    if [[ "$O" == "." ]]; then continue; fi
    if [[ "$O" == ".." ]]; then continue; fi
    if [[ "$O" == ".git" ]]; then continue; fi
    if [[ "$O" == ".gitignore" ]]; then continue; fi
    if [[ "$O" == ".gitmodules" ]]; then continue; fi
    if [[ "$O" == "setup.sh" ]]; then continue; fi
    if [[ "$O" == "README.md" ]]; then continue; fi

    rm "$O" >/dev/null 2>&1
    ln -s "$f" "$O" >/dev/null 2>&1
done
ln -s .vim/.vimrc .vimrc
shopt -u dotglob
cd - >/dev/null 2>&1

#Setup vim
git clone --recursive https://github.com/rgooler/.vim 
