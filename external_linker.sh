# Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Press <TMUX-LEADER>+I to install tpm plugins"

# global and ctags
brew install ctags global
pip install pygments


# New stuff!
# --with-mailutils probably not necessary
brew install emacs-plus@29 --with-no-frame-refocus --with-modern-sexy-v1-icon --with-native-comp
# + [ ] Install emacs font in fe-ui.el
# + [ ] link google drive
# + [ ] ln -s $HOME/Library/CloudStorage/GoogleDrive-vaarnan@gmail.com/My\ Drive $HOME/GoogleDriveGmail
brew install rg fd aspell swift-format trash mu isync
