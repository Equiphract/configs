" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since archlinux.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing archlinux.vim since it alters
" the value of the 'compatible' option.
runtime! archlinux.vim

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

set background=dark " For better contrast on dark background
set encoding=utf-8  " Set encoding always to UTF-8
set showcmd         " Show (partial) command in status line.
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching, works together with ignorecase
set incsearch       " Incremental search
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set mouse=a         " Enable mouse usage (all modes)
set number          " Show current line number
set relativenumber  " Show relative line numbers
set expandtab       " Use spaces as tab
set tabstop=2       " Spaces per tab
set shiftwidth=0    " Use value in tabstop for amount of spaces to indent
set softtabstop=-1  " Treat spaces as if they were tabs, use shiftwidth value
set autoindent      " Keeps indentation of previous line
set textwidth=80    " Set max text width to 80 charcters
set nowrap          " Don't wrap text when the line gets too long to display
set colorcolumn=+1  " Draw print margin at textwidth + 1
set scrolloff=4     " Start scrolling when 4 lines away from window border

highlight ColorColumn ctermbg=lightgrey guibg=lightgrey " Set print margin color

" Spell checking
function! ToggleSpell()
  if &spell ==# "nospell"
    set spell spelllang=de_ch
  else
    set nospell
  endif
endfunction
map <F1> :call ToggleSpell()<CR>

set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
function! ToggleVisibleWhitespace()
  if &list ==# "nolist"
    set list
  else
    set nolist
  endif
endfunction
map <F2> :call ToggleVisibleWhitespace()<CR>

" vim-plug
" Make sure to reload the vimrc and run the :PlugInstall command after adding
" a new Plugin. :PlugUpdate can be used to update all installed plugins.
call plug#begin('~/.vim/plugged')

Plug 'lervag/vimtex'

call plug#end()

