" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" General options
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if &compatible
  set nocompatible " Vi compatibility not needed
endif

if has("syntax")
  syntax on
endif

if has("termguicolors")
  set termguicolors
  " the following is apparently needed sometimes according to :h termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
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
set tabstop=4
set shiftwidth=4 " setting it to 0 did not work correctly under coc.nvim
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

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Key mappings
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let mapleader = ' '

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

" Center cursor during half page up / down
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

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

  source ~/repositories/configs/vim-plugins/coc.vim
  source ~/repositories/configs/vim-plugins/fzf.vim
  source ~/repositories/configs/vim-plugins/gruvbox_material.vim
  source ~/repositories/configs/vim-plugins/vim_polyglot.vim
  source ~/repositories/configs/vim-plugins/commentary.vim
  source ~/repositories/configs/vim-plugins/floaterm.vim

  call plug#end()
endif

colorscheme gruvbox-material " must be called after plug#end

" Sets inlay text colors, must be done after colorscheme
highlight CocErrorVirtualText guifg=red
highlight CocWarningVirtualText guifg=yellow

