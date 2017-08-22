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
    if [[ "$O" == ".config" ]]; then continue; fi

    rm "$O" >/dev/null 2>&1
    ln -s "$f" "$O" >/dev/null 2>&1
done

mkdir ~/.config
ln -s ~/.homedir/.config/fish ~/.config/fish

ln -s .bashrc .bash_profile >/dev/null 2>&1
ln -s .bashrc .bash_rc >/dev/null 2>&1
ln -s .bashrc .profile >/dev/null 2>&1
ln -s .vim/.vimrc .vimrc >/dev/null 2>&1
shopt -u dotglob
cd - >/dev/null 2>&1

#Setup vim
if [ ! -d ".vim" ]; then
  git clone --recursive https://github.com/rgooler/.vim
else
  cd ~/.vim >/dev/null 2>&1
  git submodule update --init --recursive
  cd - >/dev/null 2>&1
fi
 
exit 0
