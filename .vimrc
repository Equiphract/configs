vim9script
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# General options
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if &compatible
  set nocompatible # Vi compatibility not needed
endif

if has("syntax")
  syntax enable
endif

if has("termguicolors") && ($TERM == "st-256color" || $TERM == "tmux-256color")
  set termguicolors
  # the following is apparently needed sometimes according to :h
  # xterm-true-color
  &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

filetype plugin indent on

set background=dark
set encoding=utf-8
set showcmd
set ignorecase
set smartcase
set incsearch
set nohlsearch
set autowrite
set hidden
set mouse=a
set number
set relativenumber
set expandtab
set tabstop=4
set shiftwidth=0 # uses the tabstop value
set softtabstop=-1
set autoindent
set textwidth=80
set nowrap
set colorcolumn=+1
set scrolloff=4
set ruler
set backspace=indent,eol,start
set nojoinspaces
set listchars=tab:>·,trail:~,extends:>,precedes:<
set list
set belloff=all
set signcolumn=number

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Key mappings
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

g:mapleader = ' '
noremap <F2> :edit $MYVIMRC<CR>
noremap <F3> :source $MYVIMRC<CR>

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Vim-Plug
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Make sure to reload the vimrc and run the :PlugInstall command after adding
# a new Plugin. :PlugUpdate can be used to update all installed plugins.
if ! empty(globpath(&rtp, 'autoload/plug.vim'))
    plug#begin('~/.vim/plugged')

    source ~/repos/configs/vim-plugins/fzf.vim
    source ~/repos/configs/vim-plugins/commentary.vim
    source ~/repos/configs/vim-plugins/vim_lsp.vim
    source ~/repos/configs/vim-plugins/colorscheme.vim
    Plug 'rhysd/vim-healthcheck'

    plug#end()
endif

colorscheme carbonfox

