" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" General options
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if &compatible 
  set nocompatible " Vi compatibility not needed
endif

if has("syntax")
  syntax on
endif

filetype plugin indent on

set background=dark
set encoding=utf-8
set showcmd
set ignorecase
set smartcase
set incsearch
set autowrite
set hidden
set mouse=a
set number
set relativenumber
set expandtab
set tabstop=2
set shiftwidth=0
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

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Key mappings
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Spell checking
function! ToggleSpell()
  if &spell ==# "nospell"
    set spell spelllang=de_ch
  elseif &spell && &spelllang ==# "de_ch"
    set spelllang=en_gb
  else
    set nospell
  endif
endfunction
map <F1> :call ToggleSpell()<CR>

" Run with Python
map <F2> :w !python<CR>

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Autocommands
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Vim-Plug
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Make sure to reload the vimrc and run the :PlugInstall command after adding
" a new Plugin. :PlugUpdate can be used to update all installed plugins.
if ! empty(globpath(&rtp, 'autoload/plug.vim'))
  call plug#begin('~/.vim/plugged')

  Plug 'lervag/vimtex'

  call plug#end()
endif

