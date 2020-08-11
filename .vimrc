" Spaces & Tabs
set tabstop=4
set softtabstop=4
set expandtab

" UI Config
set number
set showcmd
set cursorline
filetype indent on
set wildmenu
set lazyredraw
set showmatch

" Dracula Theme
packadd! dracula
packadd! dracula_pro
syntax enable
let g:dracula_colorterm = 0
colorscheme dracula_pro
