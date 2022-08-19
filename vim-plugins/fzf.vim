" needs fzf and optionally bat for colored previews
Plug 'junegunn/fzf.vim'

" fzf file fuzzy search that respects .gitignore
" If in git directory, show only files that are committed, staged, or unstaged
" else use regular :Files
noremap <expr> <Leader>f (len(system('git rev-parse')) ?
      \ ':Files' :
      \ ':GFiles --exclude-standard --others --cached')."\<CR>"

noremap <Leader>b :Buffers<CR>

