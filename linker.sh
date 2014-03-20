#!/bin/sh
ln -s $PWD/vim $HOME/.vim
ln -s $PWD/vimrc $HOME/.vimrc
ln -s $PWD/aliases $HOME/.aliases
ln -s $PWD/tmux.conf $HOME/.tmux.conf
ln -s $PWD/git/gitignore_global $HOME/.gitignore_global
ln -s $PWD/git/gitconfig $HOME/.gitconfig
echo 'source $HOME/.bash_aliases'>>$HOME/.bashrc
. $HOME/.bashrc
