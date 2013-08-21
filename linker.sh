#!/bin/sh
ln -s $PWD/.vim $HOME/.vim
ln -s $PWD/.vimrc $HOME/.vimrc
ln -s $PWD/.bash_aliases $HOME/.bash_aliases
echo 'source $HOME/.bash_aliases'>>$HOME/.bashrc
source $HOME/.bashrc
