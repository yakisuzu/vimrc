"---------------------------------------------------------------------------
" NeoBundle
"---------------------------------------------------------------------------
" Required begin "{{{
if has('vim_starting')
  " Be iMproved
  set nocompatible
  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc! "}}}
"---------------------------------------------------------------------------

" NeoBundle 'Shougo/vimproc.vim' "{{{
if !IsWindows()
  NeoBundle 'Shougo/vimproc.vim', {
        \ 'build' : {
        \     'mac' : 'make -f make_mac.mak',
        \    },
        \ }
endif "}}}

NeoBundle 'Shougo/vimshell.vim'

NeoBundle 'Shougo/unite.vim' "{{{
if neobundle#is_installed('unite.vim')
  command! UBookmark Unite bookmark -vertical -direction=leftabove -winwidth=60 -default-action=vimfiler
  command! UBookmarkT tabe | UBookmark
  command! BookmarkT tabe ~/.cache/unite/bookmark/default
  command! UBuffer Unite buffer
endif "}}}

NeoBundle 'Shougo/vimfiler.vim' "{{{
if neobundle#is_installed('vimfiler.vim')
  let g:vimfiler_as_default_explorer = 1
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
  if IsWindows()
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

"imeが英字に戻る現象の確認
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
if !IsWindows()
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
