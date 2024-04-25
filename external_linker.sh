# Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Press <TMUX-LEADER>+I to install tpm plugins"

# global and ctags
brew install ctags global
pip install pygments

# + [ ] Native compile needs gcc/libgccjit, https://github.com/d12frosted/homebrew-emacs-plus/issues/309
brew install rg fd aspell swift-format trash mu isync webp ffmpeg gcc libgccjit

# New stuff!
# --with-mailutils probably not necessary
brew tap d12frosted/emacs-plus
brew install emacs-plus@29 --with-no-frame-refocus --with-modern-sexy-v1-icon --with-native-comp
# + [ ] Install emacs font in fe-ui.el
# + [ ] link google drive
# + [ ] ln -s $HOME/Library/CloudStorage/GoogleDrive-vaarnan@gmail.com/My\ Drive $HOME/GoogleDriveGmail
