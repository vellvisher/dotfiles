" Adapted from sample .vimrc file by Martin Brochhaus
" Presented at PyCon APAC 2012

"" Remove vi compatibility
set nocompatible

set ruler
set showcmd
set smartindent
" Breaks pasting
""" set autoindent
xnoremap p pgvy

set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again

set laststatus=2
" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Better copy & paste
set clipboard=unnamed

" Look for tags recursively
set tags=tags;/

" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn guibg=#FFF

" Real programmers don't use TABs but spaces

set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Setup Pathogen to manage your plugins
" " mkdir -p ~/.vim/autoload ~/.vim/bundle
" " curl -so ~/.vim/autoload/pathogen.vim
" https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim
" " Now you can install any plugin into a .vim/bundle/plugin-name/ folder
call pathogen#infect()
Helptags
set t_Co=256
syntax on
filetype off
filetype plugin indent on

let g:molokai_original = 1
colorscheme molokai

"""au FileType javascript call JavaScriptFold()

" map control-backspace to delete the previous word
:imap <C-BS> <C-W>

if has('gui_running')
    source $HOME/.vim/gui_settings.vim
endif

" Smart Status Line
set statusline=%F%m%r%h%w
set cursorline

"Spell checker options
set spellsuggest=5

" Add balloon tips for folded lines and mispelled words
autocmd BufEnter *.txt set spell

" ================ Persistent Undo ==================
" " Keep undo history across sessions, by storing in file.
" " Only works all the time.
"
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

"ERROR line below does not work
"autocmd BufEnter *.txt so $HOME/.vim/balloon.vim

" Add abbreviations
source $HOME/.vim/abbreviations.vim

" Add omnicomplete for filetypes
source $HOME/.vim/languages_omni.vim
set completeopt-=preview

let mapleader = ","

" Replace Ex-Mode with ,
noremap Q ,

" Gvim settings 

so $HOME/.vim/settings.vim

if has("unix")
  let s:uname = system("uname")
  if system("uname") == "Darwin\n"
    so $HOME/.vim/settings_mac.vim
  endif
endif
