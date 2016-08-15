#!/bin/sh
ln -s $PWD/vim $HOME/.vim
ln -s $PWD/vimrc $HOME/.vimrc
ln -s $PWD/emacs $HOME/.emacs
ln -s $PWD/zshrc $HOME/.zshrc
ln -s $PWD/zshenv $HOME/.zshenv
ln -s $PWD/aliases $HOME/.aliases
ln -s $PWD/aliases_disable $HOME/.aliases_disable
ln -s $PWD/tmux.conf $HOME/.tmux.conf
ln -s $PWD/tmux/colorscheme.conf $HOME/.tmux/colorscheme.conf
ln -s $PWD/tmux.reset.keys $HOME/.tmux.reset.keys
ln -s $PWD/todo.actions.d $HOME/.todo.actions.d
ln -s $PWD/git/gitignore_global $HOME/.gitignore_global
ln -s $PWD/git/gitconfig $HOME/.gitconfig
. $HOME/.zshrc
git submodule init
git submodule update
