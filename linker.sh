#!/bin/sh
if [ ! -d "~/.tmux" ]; then
  ln -s $PWD/tmux $HOME/.tmux
fi
ln -s $PWD/vim $HOME/.vim
ln -s $PWD/vimrc $HOME/.vimrc
ln -s $PWD/emacs $HOME/.emacs
ln -s $PWD/emacs.d $HOME/.emacs.d
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

# Link vimrc for NVim
mkdir -p $HOME/.config/nvim
ln -s $PWD/init.vim $HOME/.config/nvim/init.vim
