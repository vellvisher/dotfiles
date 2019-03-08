#!/bin/sh
ln -s $PWD/vim $HOME/.vim
ln -s $PWD/vimrc $HOME/.vimrc
ln -s $PWD/emacs.d $HOME/.emacs.d
ln -s $PWD/aliases $HOME/.aliases
ln -s $PWD/aliases_disable $HOME/.aliases_disable

ln -s $PWD/git/gitconfig $HOME/.gitconfig

ln -s $PWD/git/gitignore_global $HOME/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

git submodule init
git submodule update

ln -s $PWD/hgrc $HOME/.hgrc

touch ~/.emacs-custom.el
