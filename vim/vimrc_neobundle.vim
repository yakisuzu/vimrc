scriptencoding utf-8
"---------------------------------------------------------------------------
" NeoBundle
"---------------------------------------------------------------------------
" Required begin "{{{
if has('vim_starting')
  " Be iMproved
  set nocompatible
  " Required: rtp
  let &runtimepath .= ',' . g:dir_bundle . 'neobundle.vim/'
endif

let use_local = 0

" Required:
try
  call neobundle#begin(g:dir_bundle)
catch /.*/
  echom 'neobundle not installed'
  finish
endtry

" Let NeoBundle manage NeoBundle
" Required:
if !use_local
  NeoBundleFetch 'Shougo/neobundle.vim'
endif
if use_local
  call neobundle#local(g:dir_bundle, {})
endif

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc! "}}}
"---------------------------------------------------------------------------
" plugin list
if !use_local
  " for utility "{{{
  if !g:Is_windows()
    NeoBundle 'Shougo/vimproc.vim', {
          \ 'build' : {
          \     'mac' : 'make -f make_mac.mak',
          \    },
          \ }
  endif
  NeoBundle 'vim-jp/vital.vim'
  NeoBundle 'Shougo/vimshell.vim'
  "}}}
  " for unite "{{{
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'ujihisa/unite-colorscheme'
        \ , {'depends' : ['Shougo/unite.vim']}
  NeoBundle 'osyo-manga/unite-quickfix'
        \ , {'depends' : ['Shougo/unite.vim']}
  "NeoBundle 'yakisuzu/unite-breakpoint'
  "      \ , {'depends' : ['Shougo/unite.vim']}
  NeoBundle 'yakisuzu/unite-bookmarkamazing'
        \ , {'depends' : ['Shougo/unite.vim']}
  NeoBundle 'yakisuzu/unite-signamazing'
        \ , {'depends' : ['Shougo/unite.vim']}
  NeoBundle 'Shougo/vimfiler.vim'
        \ , {'depends' : ['Shougo/unite.vim']}
  NeoBundle 'kmnk/vim-unite-giti'
        \ , {'depends' : ['Shougo/unite.vim']}
  "}}}
  " for neocomplete "{{{
  if v:version > 703  && has('lua')
    NeoBundle 'Shougo/neocomplete.vim'
  endif
  NeoBundle 'Shougo/neosnippet.vim'
        \ , {'depends' : ['Shougo/neocomplete.vim']}
  NeoBundle 'Shougo/neosnippet-snippets'
        \ , {'depends' : ['Shougo/neocomplete.vim']}
 "}}}
  " for operator "{{{
  NeoBundle 'kana/vim-operator-user'
  NeoBundle 'rhysd/vim-operator-surround'
        \ , {'depends' : ['kana/vim-operator-user']}
  "}}}
  " for textobj "{{{
  NeoBundle 'kana/vim-textobj-user'
  NeoBundle 'kana/vim-textobj-function'
        \ , {'depends' : ['kana/vim-textobj-user']}
  "}}}
  " for iroiro "{{{
  " TODO: md
  " NeoBundle 'plasticboy/vim-markdown'
  NeoBundle 'yakisuzu/previm'
  NeoBundle 'tyru/open-browser.vim'

  " TODO: ime returns to the letter problem
  " NeoBundle 'cohama/lexima.vim'
  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'scrooloose/syntastic'
  NeoBundle 'vim-scripts/Align'
  if g:Is_mac()
    NeoBundle 'supermomonga/shaberu.vim'
  endif
  NeoBundle 'rhysd/clever-f.vim'
  NeoBundle 'haya14busa/incsearch.vim'
  NeoBundle 'Yggdroot/indentLine'
  NeoBundle 'mattn/emoji-vim'
  NeoBundle 'tyru/restart.vim'
 "}}}
  " for python "{{{
  NeoBundleLazy 'davidhalter/jedi-vim'
  NeoBundleLazy 'andviro/flake8-vim'
  NeoBundleLazy 'hynek/vim-python-pep8-indent'
  "}}}
  " for yaml "{{{
  NeoBundleLazy 'chase/vim-ansible-yaml'
  "}}}
  " for go "{{{
  NeoBundleLazy 'fatih/vim-go'
  "}}}
  " for lazyload "{{{
  augroup neobundlelazy
    autocmd!
    autocmd FileType python NeoBundleSource jedi-vim
    autocmd FileType python NeoBundleSource flake8-vim
    autocmd FileType python NeoBundleSource vim-python-pep8-indent
    autocmd FileType yaml NeoBundleSource vim-ansible-yaml
    autocmd FileType go NeoBundleSource vim-go
  augroup END "}}}
endif

"---------------------------------------------------------------------------
"tap setting
if neobundle#tap('vital.vim') "{{{
  command! -nargs=1 -complete=file
        \ Open call g:VMfile.open(<q-args>)
  command! OpenClipbord echom 'open ' . @+ | call g:VMfile.open(@+)
  command! OpenParenthese exe 'normal "oyi)' | echom 'open ' . @o | call g:VMfile.open(@o)

  function! neobundle#hooks.on_source(bundle)
    let g:V = vital#of('vital')
    let g:VMfile = g:V.import('System.File')
    let g:VMran  = g:V.import('Random')
    let g:VMxml  = g:V.import('Web.XML')
    let g:VMjson = g:V.import('Web.JSON')
    let g:VMhttp = g:V.import('Web.HTTP')
  endfunction

  call neobundle#untap()
endif "}}}
if neobundle#tap('vimshell.vim') "{{{
  let di_bin_path = {}
  if g:Is_mac()
    let di_bin_path = {'/usr/bin' : 'utf-8-mac'}
  elseif has('win32')
    let di_bin_path = {'C:/Program Files/Git/bin' : 'utf-8'}
  elseif has('win64')
    let di_bin_path = {'C:/Program Files (x86)/Git/bin' : 'utf-8'}
  endif
  if !empty(di_bin_path)
    let g:vimshell_interactive_encodings = di_bin_path
  endif

  function! neobundle#hooks.on_source(bundle)
  endfunction

  call neobundle#untap()
endif "}}}
if neobundle#tap('unite.vim') "{{{
  " for buffer "{{{
  command! UBuffer Unite buffer
  "}}}
  " for vimgrep "{{{
  command! -nargs=+
        \ UVimgrep call s:unite_vimgrep(<f-args>)

  function! s:unite_vimgrep(...) "{{{
    let li_args = []
    if a:0 == 1
      let li_args = ['*', a:1]
    elseif a:0 ==2
      let li_args = [a:1, a:2]
    else
      echomsg 'args count is fail'
      return 1
    endif

    let @/ = li_args[1]
    let li_cmd = [
          \   'Unite'
          \ , 'vimgrep:./**/*' . li_args[0] . ':' . li_args[1]
          \ , '-auto-preview'
          \ , '-vertical-preview'
          \ , '-no-quit'
          \ , '-tab'
          \ , '-default-action=tabopen'
          \ ]
    silent exe join(li_cmd)
  endfunction "}}}
  "}}}
  function! neobundle#hooks.on_source(bundle) "{{{
    " init unite bookmark
    call unite#sources#bookmark#define()

    " add unite action execute
    let di_action = {
          \ 'is_selectable' : 1,
          \ }
    function! di_action.func(li_c)
      for di_c in a:li_c
        call g:VMfile.open(di_c.action__path)
      endfor
    endfunction
    call unite#custom#action('jump_list', 'execute', di_action)
  endfunction "}}}
  augroup unite "{{{
    autocmd!
    autocmd FileType unite call s:filetype_unite()

    function! s:filetype_unite()
      nnoremap <silent><buffer><expr> x unite#do_action('execute')
    endfunction
  augroup END "}}}

  call neobundle#untap()
endif "}}}
if neobundle#tap('unite-breakpoint') "{{{
  command! UBreakpoint Unite breakpoint -auto-preview -vertical-preview

  call neobundle#untap()
endif "}}}
if neobundle#tap('unite-bookmarkamazing') "{{{
  command! -nargs=? -complete=customlist,s:unite_bookmarkamazing_comp
        \ UBookmarkA call s:unite_bookmarkamazing_open(<q-args>, 'default')

  function! s:unite_bookmarkamazing_comp(A,L,P) "{{{
    return unite#sources#bookmarkamazing#get_bookmark_file_complete_list(a:A, a:L, a:P, ['*'])
  endfunction "}}}
  function! s:unite_bookmarkamazing_open(st_arg, st_default) "{{{
    if &ft == 'vimfiler'
      call unite#custom#default_action('directory', 'vimfiler')
    else
      call unite#custom#default_action('directory', 'tabvimfiler')
    endif

    let st_file = empty(a:st_arg) ? a:st_default : a:st_arg
    let li_cmd = [
          \   'Unite'
          \ , 'bookmarkamazing:' . st_file
          \ , '-vertical'
          \ , '-direction=leftabove'
          \ , '-winwidth=60'
          \ ]
    silent exe join(li_cmd)
  endfunction "}}}

  function! neobundle#hooks.on_source(bundle)
    " init unite bookmarkamazing
    call unite#sources#bookmarkamazing#define()
  endfunction

  call neobundle#untap()
endif "}}}
if neobundle#tap('vimfiler.vim') "{{{
  command! -nargs=? VFexplorer VimFiler -explorer -simple -edit-action=open <args>

  let g:vimfiler_as_default_explorer = 1

  function! neobundle#hooks.on_source(bundle)
    call vimfiler#custom#profile('default', 'context', {
          \   'auto_cd' : 1
          \ , 'edit_action' : 'tabopen'
          \ , 'sort_type' : 'filename'
          \ })
  endfunction

  augroup vimfiler "{{{
    autocmd!
    autocmd FileType vimfiler call s:filetype_vimfiler()

    function! s:filetype_vimfiler()
      "nnoremap <silent><buffer><expr> <CR> vimfiler#do_switch_action('tabopen')
      " change keymap t to o
      unmap <buffer> t
      unmap <buffer> T
      nmap <buffer> o <Plug>(vimfiler_expand_tree)
      nmap <buffer> O <Plug>(vimfiler_expand_tree_recursive)
    endfunction
  augroup END "}}}

  call neobundle#untap()
endif "}}}
if neobundle#tap('neocomplete.vim') "{{{
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " neocomplete locks when 'iminsert' is non-zero.
  let g:neocomplete#lock_iminsert = 1

  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  let g:neocomplete#sources#omni#input_patterns.go = '\h\w\.\w*'

  call neobundle#untap()
endif "}}}
if neobundle#tap('neosnippet.vim') "{{{
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
endif "}}}
if neobundle#tap('vim-quickrun') "{{{
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
if neobundle#tap('Align') "{{{
  " 0:for utf-8?
  " 1(default):fastest
  " 2:Number of spacing codepoints?
  " 3:Virtual length?, multi-byte support
  command! -nargs=1 SetAlignXstrlen let g:Align_xstrlen=<args>

  call neobundle#untap()
endif "}}}
if neobundle#tap('vim-operator-surround') "{{{
  map <silent> <Leader>sa <Plug>(operator-surround-append)
  map <silent> <Leader>sd <Plug>(operator-surround-delete)
  map <silent> <Leader>sr <Plug>(operator-surround-replace)

  call neobundle#untap()
endif "}}}
if neobundle#tap('shaberu.vim') "{{{
  function! g:Shaberu_say_print(st_arg)
    echom a:st_arg
    call shaberu#say(a:st_arg)
  endfunction

  function! g:Say_random(li_str)
    call g:Shaberu_say_print(g:VMran.sample(a:li_str))
  endfunction

  augroup shaberu
    autocmd!
    autocmd VimEnter * call g:Say_random(['ビムへようこそ', 'ご注文はビムですか', 'ビ、ビムなんかじゃないんだからね', 'イーマックスへようこそ', 'ビムです', 'ビムではありません'])
    autocmd MenuPopup * call g:Say_random(['そんなにマウスが好きですか'])
    autocmd VimLeavePre * call g:Say_random(['お疲れ様でした。進捗どうですか', '終了します'])
  augroup END

  call neobundle#untap()
endif "}}}
if neobundle#tap('incsearch.vim') "{{{
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  call neobundle#untap()
endif "}}}
if neobundle#tap('indentLine') "{{{
  let g:indentLine_color_gui='#808080'
endif "}}}
if neobundle#tap('open-browser.vim') "{{{
  command! OpenBrowserCurrent execute "OpenBrowser" "file:///" . expand('%:p:gs?\\?/?')

  call neobundle#untap()
endif "}}}
if neobundle#tap('syntastic') "{{{
  let g:syntastic_javascript_checkers=['eslint']

  call neobundle#untap()
endif "}}}
if neobundle#tap('vim-ansible-yaml') "{{{
  command! SetAnsible setl ft=ansible

  call neobundle#untap()
endif "}}}
if neobundle#tap('vim-go') "{{{
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_interfaces = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1

  call neobundle#untap()
endif "}}}

"---------------------------------------------------------------------------
" Required end "{{{
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck "}}}
