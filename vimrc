" ------------------------------
" Colemak DHm keymaps
" ------------------------------
noremap <silent> m h
noremap <silent> n j
noremap <silent> e k
noremap <silent> i l

noremap <silent> M H
noremap <silent> N J
noremap <silent> E K
noremap <silent> I L

noremap <silent> <C-m> <C-h>
noremap <silent> <C-n> 4j
noremap <silent> <C-e> 4k
noremap <silent> <C-i> <C-l>

noremap <silent> h i
noremap <silent> j m
noremap <silent> k n
noremap <silent> l e

noremap <silent> H I
noremap <silent> J M
noremap <silent> K N
noremap <silent> L E

noremap <silent> <C-h> <C-i>
noremap <silent> <C-j> <C-m>
noremap <silent> <C-k> <C-n>
noremap <silent> <C-l> <C-e>

nnoremap <silent> <C-w>m <C-w>h
nnoremap <silent> <C-w>n <C-w>j
nnoremap <silent> <C-w>e <C-w>k
nnoremap <silent> <C-w>i <C-w>l

" ------------------------------
" Generic Keymaps
" ------------------------------
nnoremap <Space> <Nop>
let mapleader = " "

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

noremap <silent> <C-u> <C-u>zz
noremap <silent> <C-d> <C-d>zz

nnoremap <silent> <C-W>< 20<C-W><
nnoremap <silent> <C-W>> 20<C-W>>
nnoremap <silent> <C-W>- 20<C-W>-
nnoremap <silent> <C-W>+ 20<C-W>+

" ------------------------------
" General Settings
" ------------------------------
set clipboard=unnamedplus
set relativenumber
set noswapfile
set undofile

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

if has("syntax")
  syntax on
endif

if has('termguicolors')
  set termguicolors
endif

" ------------------------------
" Colorscheme
" ------------------------------
colorscheme retrobox
set background=dark
