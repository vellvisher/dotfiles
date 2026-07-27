#!/bin/sh
# Idempotent: safe to re-run. `ln -sfn` replaces existing symlinks in place,
# `mkdir -p` is a no-op when the dir exists.
ln -sfn $PWD/vim $HOME/.vim
ln -sfn $PWD/vimrc $HOME/.vimrc
ln -sfn $PWD/emacs.d $HOME/.emacs.d
ln -sfn $PWD/aliases $HOME/.aliases
ln -sfn $PWD/aliases_disable $HOME/.aliases_disable

ln -sfn $PWD/zprofile $HOME/.zprofile

ln -sfn $PWD/globalrc $HOME/.globalrc
ln -sfn $PWD/ctags $HOME/.ctags

ln -sfn $PWD/git/gitconfig $HOME/.gitconfig

ln -sfn $PWD/git/gitignore_global $HOME/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

git submodule init
git submodule update

ln -sfn $PWD/hgrc $HOME/.hgrc

touch ~/.emacs-custom.el

mkdir -p ~/Library/KeyBindings
ln -sfn $PWD/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict

mkdir -p ~/.claude
ln -sfn $PWD/claude/CLAUDE.md $HOME/.claude/CLAUDE.md
