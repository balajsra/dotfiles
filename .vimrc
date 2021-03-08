" Sravan's Vimrc

" Don't try to be vi compatible
set nocompatible

" Syntax Highlighting
syntax on

" Pick a leader key
let mapleader = "\\"

" Security
set modelines=0

" Show line numbers
set number relativenumber

" Show file stats
set ruler

" Blink cursors on error instead of beeping
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=110
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround
set smarttab
set autoindent

" Cursor Motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jumb between pairs

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Exit Inser Mode Easily
:inoremap jk <esc>

" UI Config
set cursorline
filetype indent on
set wildmenu
set lazyredraw
set showmatch

" Dracula Theme
packadd! dracula
packadd! dracula_pro
let g:dracula_colorterm = 0
colorscheme dracula_pro

