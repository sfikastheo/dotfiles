" ------------------------------
" Colemak DHm langmap
" ------------------------------
set langmap=mh,nj,ek,il,hi,jm,kn,le,MH,NJ,EK,IL,HI,JM,KN,LE

" ------------------------------
" Key Mappings
" ------------------------------
nnoremap <Space> <Nop>
let mapleader = " "

nnoremap <silent> <leader>/ :noh<CR>

nnoremap <silent> <C-c> <Esc>
vnoremap <silent> <C-c> <Esc>
onoremap <silent> <C-c> <Esc>
vnoremap <silent> ,, <Esc>
onoremap <silent> ,, <Esc>
inoremap <silent> ,, <Esc>
tnoremap <silent> ,, <C-\><C-n>

nnoremap <silent> d "_d
vnoremap <silent> d "_d
nnoremap <silent> x "_x
vnoremap <silent> x "_x
nnoremap <silent> D "_D
vnoremap <silent> D "_D
nnoremap <silent> <leader>d d
vnoremap <silent> <leader>d d
nnoremap <silent> <leader>x x
vnoremap <silent> <leader>x x
nnoremap <silent> <leader>D D
vnoremap <silent> <leader>D D

nnoremap <silent> <C-n> 4j
vnoremap <silent> <C-n> 4j
onoremap <silent> <C-n> 4j

nnoremap <silent> <C-e> 4k
vnoremap <silent> <C-e> 4k
onoremap <silent> <C-e> 4k

nnoremap <silent> <C-u> <C-u>zz
vnoremap <silent> <C-u> <C-u>zz
onoremap <silent> <C-u> <C-u>zz

nnoremap <silent> <C-d> <C-d>zz
vnoremap <silent> <C-d> <C-d>zz
onoremap <silent> <C-d> <C-d>zz

nnoremap <silent> <C-W>< 20<C-W><
nnoremap <silent> <C-W>> 20<C-W>>
nnoremap <silent> <C-W>- 20<C-W>-
nnoremap <silent> <C-W>+ 20<C-W>+

" ------------------------------
" General Settings
" ------------------------------
set relativenumber

set scrolloff=8
set sidescrolloff=8
set splitbelow
set splitright

set wrap
set expandtab
set autoindent
set smartindent
set shiftwidth=4
set softtabstop=4
set tabstop=4

set ignorecase
set smartcase

set clipboard+=unnamedplus

set noswapfile
set undofile

if has("syntax")
  syntax on
endif
