vim9script
# needs fzf and optionally bat for colored previews
Plug 'junegunn/fzf.vim'

def IsInGitRepo(): bool
    system('git rev-parse')
    return v:shell_error == 0
enddef

noremap <expr> <Leader>f IsInGitRepo()
    \ ? ":GFiles --exclude-standard --others --cached<CR>"
    \ : ":Files<CR>"

noremap <Leader>b :Buffers<CR>

