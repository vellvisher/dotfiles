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

"Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.

set pastetoggle=<F2>
set clipboard=unnamed

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
" vnoremap < <gv  " better indentation
" vnoremap > >gv  " better indentation
vmap <Tab> >gv
vmap <S-Tab> <gv
" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/ 

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
set t_Co=256
syntax on
filetype off
filetype plugin indent on

let g:molokai_original = 0
colorscheme molokai

"""au FileType javascript call JavaScriptFold()

" map control-backspace to delete the previous word
:imap <C-BS> <C-W>

" Disabe ex mode
:map Q <Nop>

" Gvim settings 
if has('gui_running')
    source $HOME/.vim/gui_settings.vim
endif

" Smart Status Line
set statusline=%F%m%r%h%w
set cursorline

"Spell checker options
set spellsuggest=5

"Remap : to ;
nnoremap ; :

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

so $HOME/.vim/settings.vim

let g:session_autosave = 'no'
