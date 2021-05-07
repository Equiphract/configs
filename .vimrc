" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" My tweaks
" Set line number
:set number

" 2 spaces per tab (https://vim.fandom.com/wiki/Converting_tabs_to_spaces)
:set expandtab tabstop=2 shiftwidth=2

" Set right margin to 81
:set colorcolumn=81

" Spell checking
:function! ToggleSpell()
:  if &spell ==# "nospell"
:    set spell spelllang=de_ch
:  else
:    set nospell
:  endif
:endfunction
:map <F1> :call ToggleSpell()<CR>

" jj as escape from insert mode
" :imap jj <Esc>
" Use alt+h,j,k or l instead

" Set whitespace visible
:set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
:function! ToggleVisibleWhitespace()
:  if &list ==# "nolist"
:    set list
:  else
:    set nolist
:  endif
:endfunction
:map <F2> :call ToggleVisibleWhitespace()<CR>

" vim-plug
" Make sure to reload the vimrc and run the :PlugInstall command after adding
" a new Plugin. :PlugUpdate can be used to update all installed plugins.
call plug#begin('~/.vim/plugged')

Plug 'lervag/vimtex'

call plug#end()

