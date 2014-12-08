"---------------------------------------------------------------------------
" NeoBundle
"---------------------------------------------------------------------------
" Required begin "{{{
if has('vim_starting')
  " Be iMproved
  set nocompatible
  " Required: rtp
  let &runtimepath = &runtimepath. ','. g:dir_bundle. 'neobundle.vim/'
endif

try
  call g:neobundle#exists_not_installed_bundles()
catch /.*/
  echom 'neobundle not installed'
  finish
endtry

" Required:
call neobundle#begin(g:dir_bundle)

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc! "}}}
"---------------------------------------------------------------------------

" NeoBundle 'Shougo/vimproc.vim' "{{{
if !g:Is_windows()
  NeoBundle 'Shougo/vimproc.vim', {
        \ 'build' : {
        \     'mac' : 'make -f make_mac.mak',
        \    },
        \ }
endif "}}}

NeoBundle 'Shougo/vimshell.vim'

NeoBundle 'Shougo/unite.vim' "{{{
if neobundle#is_installed('unite.vim')
  NeoBundle 'ujihisa/unite-colorscheme'
  NeoBundle 'osyo-manga/unite-quickfix'

  command! UBuffer Unite buffer

  " for bookmark
  command! -nargs=? -complete=customlist,s:comp_unite_bookmark
        \ UBookmark call s:unite_bookmark_open(<q-args>)
  command! -nargs=? -complete=customlist,s:comp_unite_bookmark
        \ UBookmarkT tabe | UBookmark <args>
  command! -nargs=? -complete=customlist,s:comp_unite_bookmark
        \ BookmarkT call s:unite_bookmark_edit(<q-args>)

  " TODO: first time g:unite_source_bookmark_directory is fail
  function! s:comp_unite_bookmark(A,L,P)
    return sort(map(
          \ split(glob(g:unite_source_bookmark_directory . '/*'), '\n'),
          \ 'fnamemodify(v:val, ":t")'))
  endfunction
  function! s:unite_bookmark_open(...)
    let li_arg = ['bookmark'] + a:000
    let li_option = [
          \  '-vertical'
          \ ,'-direction=leftabove'
          \ ,'-winwidth=60'
          \ ,'-default-action=vimfiler'
          \ ]
    let st_com = 'Unite '. join(li_arg,':'). ' '. join(li_option, ' ')
    silent exe st_com
  endfunction
  function! s:unite_bookmark_edit(...)
    let st_arg = empty(a:1) ? 'default' : a:1
    let st_com = 'tabe '. g:unite_source_bookmark_directory. '/'. st_arg
    silent exe st_com
  endfunction

endif "}}}

NeoBundle 'Shougo/vimfiler.vim' "{{{
if neobundle#is_installed('vimfiler.vim')
  let g:vimfiler_as_default_explorer = 1

  augroup vimfiler
    autocmd!
    autocmd FileType vimfiler call s:filetype_vimfiler()
  augroup END
  function! s:filetype_vimfiler()
    nnoremap <silent><buffer><expr> <CR> vimfiler#do_switch_action('tabopen')
    " change keymap t to o
    unmap <buffer> t
    unmap <buffer> T
    nmap <buffer> o <Plug>(vimfiler_expand_tree)
    nmap <buffer> O <Plug>(vimfiler_expand_tree_recursive)
  endfunction
endif "}}}

"NeoBundle 'Shougo/neocomplete.vim' "{{{
if v:version > 703  && has('lua')
  NeoBundle 'Shougo/neocomplete.vim'
  if neobundle#is_installed('neocomplete.vim')
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " neocomplete locks when 'iminsert' is non-zero.
    let g:neocomplete#lock_iminsert = 1
  endif

  NeoBundle 'Shougo/neosnippet.vim'
  NeoBundle 'Shougo/neosnippet-snippets'
  if neobundle#is_installed('neosnippet.vim')
    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
          \ "\<Plug>(neosnippet_expand_or_jump)"
          \: pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
          \ "\<Plug>(neosnippet_expand_or_jump)"
          \: "\<TAB>"

    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif
  endif
endif "}}}

NeoBundle 'thinca/vim-quickrun' "{{{
if neobundle#is_installed('vim-quickrun')
  let g:quickrun_config = {
        \  "_" : {
        \    "runner" : "vimproc",
        \    "runner/vimproc/updatetime" : 60
        \  },
        \}
  if g:Is_windows()
    let g:quickrun_config = {
          \  "cs/csc": {
          \    "command": "C:/Windows/Microsoft.NET/Framework64/v4.0.30319/csc.exe",
          \  },
          \}
  endif
endif "}}}

NeoBundle 'vim-scripts/Align' "{{{
if neobundle#is_installed('Align')
  " 0:for utf-8?
  " 1(default):fastest
  " 2:Number of spacing codepoints?
  " 3:Virtual length?, multi-byte support
  command! -nargs=1 SetAlignXstrlen let g:Align_xstrlen=<args>
endif "}}}

" TODO: ime returns to the letter problem
"NeoBundle 'cohama/lexima.vim'

NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'haya14busa/incsearch.vim' "{{{
if neobundle#is_installed('incsearch.vim')
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
endif "}}}

NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'yakisuzu/previm'
NeoBundle 'tyru/open-browser.vim' "{{{
if neobundle#is_installed('open-browser.vim')
  command! OpenBrowserCurrent execute "OpenBrowser" "file:///" . expand('%:p:gs?\\?/?')
endif "}}}

NeoBundle 'tpope/vim-fugitive'

" NeoBundle 'kakkyz81/evervim' "{{{
if !g:Is_windows()
  NeoBundle 'kakkyz81/evervim'
  " let g:evervim_devtoken=''
endif
"}}}

NeoBundle 'tyru/restart.vim'

"---------------------------------------------------------------------------
" Required end "{{{
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck "}}}
