vim9script
Plug 'prabirshrestha/vim-lsp'

g:lsp_log_verbose = 1
g:lsp_log_file = expand('/tmp/vim_lsp.log')
g:lsp_use_native_client = 1
g:lsp_semantic_enabled = 1
g:lsp_format_sync_timeout = 1000
g:lsp_highlights_enabled = 1
g:lsp_textprop_enabled = 1
g:lsp_inlay_hints_enabled = 1

# vim-lsp automatically distributes folds throughout the file and by default
# foldlevel is 0 which means that all folds will be closed by default.
set foldlevel=99

augroup vim_lsp
    autocmd!

    if (executable('vim-language-server'))
        autocmd User lsp_setup lsp#register_server({
        \   'name': 'vim-language-server',
        \   'cmd': ['vim-language-server', '--stdio'],
        \   'allowlist': ['vim'],
        \   'initialization_options': {
        \       'vimruntime': $VIMRUNTIME,
        \       'runtimepath': &rtp,
        \       'iskeyword': &isk,
        \       'diagnostic': {
        \           'enable': false
        \       }
        \   }
        \ })
    endif

    var lemminx_location =
        '~/repos/lemminx/org.eclipse.lemminx/target/org.eclipse.lemminx-uber.jar'
    if executable('java') && filereadable(expand(lemminx_location))
        autocmd User lsp_setup call lsp#register_server({
        \   'name': 'lemminx',
        \   'cmd': [
        \       'java',
        #\        '-noverify', <- deprecated
        \       '-Xmx1G',
        \       '-XX:+UseStringDeduplication',
        \       '-Dfile.encoding=UTF-8',
        \       '-jar',
        \       expand(lemminx_location)
        \   ],
        \   'whitelist': ['xml']
        \ })
    endif

    var equinox_launcher =
        '~/downloads/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar'
    if executable('java') && filereadable(expand(equinox_launcher))
        autocmd User lsp_setup call lsp#register_server({
        \   'name': 'eclipse.jdt.ls',
        \   'cmd': [
        \       'java',
        \       '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        \       '-Dosgi.bundles.defaultStartLevel=4',
        \       '-Declipse.product=org.eclipse.jdt.ls.core.product',
        \       '-Dlog.level=ALL',
        #\       '-noverify', <- deprecated
        \       '-Dfile.encoding=UTF-8',
        \       '-Xmx1G',
        \       '-jar',
        \       expand(equinox_launcher),
        \       '-configuration',
        \       expand('~/downloads/eclipse.jdt.ls/config_linux'),
        \       '-data',
        \       getcwd()
        \   ],
        \   'whitelist': ['java'],
        \ })
    endif

    if executable('bash-language-server')
        autocmd User lsp_setup call lsp#register_server({
        \   'name': 'bash-language-server',
        \   'cmd': [&shell, &shellcmdflag, 'bash-language-server start'],
        \   'allowlist': ['sh'],
        \ })
    endif
augroup end

augroup vim_lsp_folding
    autocmd!

    autocmd FileType xml setlocal
    \ foldmethod=expr
    \ foldexpr=lsp#ui#vim#folding#foldexpr()
    \ foldtext=lsp#ui#vim#folding#foldtext()
augroup end

def On_lsp_buffer_enabled()
    setlocal omnifunc=lsp#complete

    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> <Leader>s <plug>(lsp-document-symbol-search)
    nmap <buffer> <Leader>S <plug>(lsp-workspace-symbol-search)
    nmap <buffer> <Leader>r <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    # nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <Leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)

    if &filetype == 'vim'
        nmap <buffer> <Leader>k <plug>(lsp-hover)
    else
        nmap <buffer> K <plug>(lsp-hover)
    endif

    nnoremap <buffer> <expr><c-f> lsp#scroll(+1)
    nnoremap <buffer> <expr><c-b> lsp#scroll(-1)

    # refer to doc to add more commands
enddef

augroup lsp_install
    autocmd!

    # call On_lsp_buffer_enabled only for languages that has the server
    # registered.
    autocmd User lsp_buffer_enabled On_lsp_buffer_enabled()
augroup END
