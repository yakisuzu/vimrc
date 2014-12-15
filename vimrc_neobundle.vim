scriptencoding utf-8
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

NeoBundle 'vim-jp/vital.vim' "{{{
if neobundle#tap('vital.vim')
  function! neobundle#hooks.on_source(bundle)
    let g:V = vital#of('vital')
  endfunction

  call neobundle#untap()
endif "}}}

NeoBundle 'Shougo/vimshell.vim'

NeoBundle 'Shougo/unite.vim' "{{{
if neobundle#tap('unite.vim')
  NeoBundle 'ujihisa/unite-colorscheme'
  NeoBundle 'osyo-manga/unite-quickfix'
  NeoBundle 'yakisuzu/unite-breakpoint'

  command! UBreakpoint Unite breakpoint
  command! UBuffer Unite buffer

  " for vimgrep
  command! -nargs=1
        \ UVimgrep call s:unite_vimgrep(<q-args>)

  function! s:unite_vimgrep(st_arg) "{{{
    CdCurrent
    let li_cmd = [
          \   'Unite'
          \ , 'vimgrep:./**/*.*:' . a:st_arg
          \ , '-auto-preview'
          \ , '-vertical-preview'
          \ , '-no-quit'
          \ ]
    silent exe join(li_cmd)
  endfunction "}}}

  " for bookmark
  command! -nargs=? -complete=customlist,s:comp_unite_bookmark
        \ UBookmark call s:unite_bookmark_open(<q-args>)
  command! -nargs=? -complete=customlist,s:comp_unite_bookmark
        \ BookmarkT call s:unite_bookmark_edit(<q-args>)

  " TODO: first time g:unite_source_bookmark_directory is fail
  function! s:comp_unite_bookmark(A,L,P) "{{{
    return sort(map(
          \ split(glob(g:unite_source_bookmark_directory . '/*'), '\n'),
          \ 'fnamemodify(v:val, ":t")'))
  endfunction "}}}
  function! s:unite_bookmark_open(st_arg) "{{{
    let li_cmd = [
          \   'Unite'
          \ , 'bookmark:' . a:st_arg
          \ , '-vertical'
          \ , '-direction=leftabove'
          \ , '-winwidth=60'
          \ ]
    silent exe join(li_cmd)
  endfunction "}}}
  function! s:unite_bookmark_edit(st_arg) "{{{
    let st_file = empty(a:st_arg) ? 'default' : a:st_arg
    let st_cmd = 'tabe '. g:unite_source_bookmark_directory. '/'. st_file
    silent exe st_cmd
  endfunction "}}}

  function! neobundle#hooks.on_source(bundle)
    call unite#custom#default_action('directory', 'tabvimfiler')

    let di_action = {
          \ 'is_selectable' : 1,
          \ }
    function! di_action.func(li_c)
      let VMfile = g:V.import('System.File')
      for di_c in a:li_c
        call VMfile.open(di_c.action__path)
      endfor
    endfunction
    call unite#custom#action('jump_list', 'execute', di_action)
  endfunction

  augroup unite
    autocmd!
    autocmd FileType unite call s:filetype_unite()
  augroup END
  function! s:filetype_unite()
    nnoremap <silent><buffer><expr> x unite#do_action('execute')
  endfunction

  call neobundle#untap()
endif "}}}

NeoBundle 'Shougo/vimfiler.vim' "{{{
if neobundle#tap('vimfiler.vim')
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

  call neobundle#untap()
endif "}}}

"NeoBundle 'Shougo/neocomplete.vim' "{{{
if v:version > 703  && has('lua')
  NeoBundle 'Shougo/neocomplete.vim'
  if neobundle#tap('neocomplete.vim')
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " neocomplete locks when 'iminsert' is non-zero.
    let g:neocomplete#lock_iminsert = 1

    call neobundle#untap()
  endif

  NeoBundle 'Shougo/neosnippet.vim'
  NeoBundle 'Shougo/neosnippet-snippets'
  if neobundle#tap('neosnippet.vim')
    " Plugin key-mappings.
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    xmap <C-k> <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
          \ "\<Plug>(neosnippet_expand_or_jump)"
          \ : pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
          \ "\<Plug>(neosnippet_expand_or_jump)"
          \ : "\<TAB>"

    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif

    call neobundle#untap()
  endif
endif "}}}

NeoBundle 'thinca/vim-quickrun' "{{{
if neobundle#tap('vim-quickrun')
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

  call neobundle#untap()
endif "}}}

NeoBundle 'vim-scripts/Align' "{{{
if neobundle#tap('Align')
  " 0:for utf-8?
  " 1(default):fastest
  " 2:Number of spacing codepoints?
  " 3:Virtual length?, multi-byte support
  command! -nargs=1 SetAlignXstrlen let g:Align_xstrlen=<args>

  call neobundle#untap()
endif "}}}

" TODO: ime returns to the letter problem
" NeoBundle 'cohama/lexima.vim'

" NeoBundle 'supermomonga/shaberu.vim' "{{{
let g:nu_plugin_shaberu = 0
if g:Is_mac()
  NeoBundle 'supermomonga/shaberu.vim'
  if neobundle#tap('shaberu.vim')
    let g:nu_plugin_shaberu = 1
    augroup shaberu
      autocmd!
      autocmd VimEnter * call g:SayRandom(['ビムへようこそ', 'ご注文はビムですか', 'ビ、ビムなんかじゃないんだからね'])
      autocmd VimLeave * call g:SayRandom(['お疲れ様でした。進捗どうですか'])
    augroup END

    call neobundle#untap()
  endif
endif "}}}

NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'haya14busa/incsearch.vim' "{{{
if neobundle#tap('incsearch.vim')
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  call neobundle#untap()
endif "}}}

NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'yakisuzu/previm'
NeoBundle 'tyru/open-browser.vim' "{{{
if neobundle#tap('open-browser.vim')
  command! OpenBrowserCurrent execute "OpenBrowser" "file:///" . expand('%:p:gs?\\?/?')

  call neobundle#untap()
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
