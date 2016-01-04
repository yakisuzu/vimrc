scriptencoding utf-8
"---------------------------------------------------------------------------
" 編集に関する設定:"{{{
" タブの画面上での幅 ts
set tabstop=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない) ws
set nowrapscan
"}}}

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:"{{{
" 行番号を非表示 (number:表示) nu
set nonumber
" タブや改行を表示 (list:表示)
set list
" どの文字でタブや改行を表示するかを設定 lcs
set listchars=tab:>\ ,extends:<,trail:-,eol:@
"}}}

"---------------------------------------------------------------------------
" ファイル操作に関する設定:"{{{
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
set nobackup
" undoファイルを作成しない
set noundofile
" swapファイルを作成しない
set noswapfile
"}}}

"---------------------------------------------------------------------------
" 追加"{{{
" 無名レジスタのかわりにクリップボードレジスタ '*' を使用 cb
set clipboard+=unnamed
" カーソルがある画面上の行をCursorLineで強調する|hl-CursorLine| cul
set cursorline
" タブページのラベルを表示 stal
set showtabline=2
" 隠れ状態にする hid
set hidden
" コマンドと検索の履歴数 hi
set history=500
" <Tab> を挿入するとき、代わりに適切な数の空白を使う et
set expandtab
" インデントに使われる空白の数 sw
set shiftwidth=2
" 折り畳みの種類 fdm
set foldmethod=marker
" 自動的に読み直す ar
set autoread
" 進数 nf
set nrformats=
" Vim内部で使われる文字エンコーディングを設定する enc
if g:Is_windows() && !has('gui_running')
  set encoding=cp932
else
  set encoding=utf8
endif
" ファイル編集時に考慮される文字エンコーディングリスト fencs
set fileencodings+=cp932
" <EOL> を、カレントバッファについて設定する ff
"let &ff = g:Is_windows() ? 'dos' : 'unix'
" ステータス行の表示内容を設定する stl
set statusline=%<%f\ %m%r%h%w%{'[enc='.&enc.'][ff='.&ff.']\ [fenc='.&fenc.'][ft='.&ft.']'}%=%l,%c%V%8P
" ワイルドカードの展開時と、ファイル／ディレクトリ名の補完時に無視される wig
set wildignore+=tags
" テキスト表示の方法を変える dy
set display=lastline
"}}}

"---------------------------------------------------------------------------
" キーマップ追加"{{{
" ノーマル、ビジュアル、選択、演算待ち状態
map <C-j> <Esc>
map <Space> [space]
noremap [space]h ^
noremap [space]j <C-f>zz
noremap [space]k <C-b>zz
noremap [space]l $
noremap j gj
noremap k gk
noremap <Leader>p "0p
noremap <Leader>P "0P
" ビジュアル、選択
vnoremap * y/<C-r>0<CR>N
vnoremap [space]/ :s///g<Left><Left>
vnoremap <Leader>h y:tab<Space>help<Space><C-r>0
" 挿入、コマンドライン
noremap! <C-j> <Esc>
" ノーマル
nnoremap Y y$
nnoremap n nzz
nnoremap N Nzz
nnoremap tg gT
nnoremap zl 20zl
nnoremap zh 20zh
nnoremap * yiw/<C-r>0<CR>N
"TODO macデフォルトのvimで:nohlsearch<CR>がバグる
nnoremap <Esc> :nohlsearch<CR>
nnoremap <C-l> :checktime<CR><C-l>
nnoremap [space]<Tab> <C-w><C-w>
nnoremap [space]/ :%s///g<Left><Left>
nnoremap [space]o o<Esc>
nnoremap [space]d :bd<CR>
nnoremap <Leader>h yiw:tab<Space>help<Space><C-r>0
nnoremap <C-]> g<C-]>
"}}}

"---------------------------------------------------------------------------
" 自動コマンド追加"{{{
" ファイルタイプ更新
let s:markdown_add_suffix = 1
augroup markdown
  autocmd!
  autocmd BufRead,BufNewFile *.md setlocal nowrap
  autocmd BufWritePre *.md call s:writePre_md()

  command! ToggleMarkdownSuffix let s:markdown_add_suffix = (s:markdown_add_suffix ? 0 : 1)
  function! s:writePre_md()
    silent %s/\v^#.*\zs  $//ge
    silent %s/\v[^ ]\zs $//ge

    let regexList = [
          \ '^$'
          \ ,'^#'
          \ ,'^---'
          \ ,'^```'
          \ ,'^\|'
          \ ,'  $'
          \ ]
    let exeCom = 'v/\v(' . join(regexList,'|') . ')/normal A  '

    if s:markdown_add_suffix
      silent exe exeCom
    else
      silent %s/  $//ge
    endif
  endfunction
augroup END

augroup java
  autocmd!
  autocmd BufRead,BufNewFile *.java call s:bufRead_java()

  function! s:bufRead_java()
    if &fdm != 'diff'
      set fdm=syntax
    endif
    SetExpandtabNo
  endfunction
augroup END

augroup wsf
  autocmd!
  autocmd BufRead,BufNewFile *.wsf set ft=javascript
augroup END
"}}}

"---------------------------------------------------------------------------
" コマンド追加"{{{
command! -nargs=1 -complete=help H tab h <args>
command! -nargs=1 -complete=command DebugProfile call g:Debug_profile(<q-args>)

command! VimrcSo so ~/_vimrc
command! GVimrcSo so ~/_gvimrc
command! Vrapperrc tabe +set\ ft=vim ~/_vrapperrc
command! -nargs=? -complete=customlist,s:vimrc_comp
      \ VimrcOpen call s:vimrc_open(<q-args>, 'vimrc_base.vim')
command! -nargs=? -complete=customlist,s:gvimrc_comp
      \ GVimrcOpen call s:vimrc_open(<q-args>, 'gvimrc_base.vim')
command! VimrcLocalOpen tabe ~/_vimrc_local

function! s:vimrc_comp(A,L,P) "{{{
  return g:File_list(g:dir_vimrc . 'vimrc_*')
endfunction "}}}
function! s:gvimrc_comp(A,L,P) "{{{
  return g:File_list(g:dir_vimrc . 'gvimrc_*')
endfunction "}}}
function! s:vimrc_open(st_file, st_default_file) "{{{
  let st_exe_file = !empty(a:st_file) ? a:st_file : a:st_default_file
  let st_path = glob(g:dir_vimrc . st_exe_file)
  if !empty(st_path)
    exe join(['tabe', st_path])
  endif
endfunction "}}}

command! -nargs=1 SetCo set columns+=<args>
command! -nargs=1 SetLines set lines+=<args>
command! -nargs=1 SetSpLinesUp normal <args>-
command! -nargs=1 SetSpLinesDown normal <args>+
command! -nargs=1 SetSpCoRight normal <args>>
command! -nargs=1 SetSpCoLeft normal <args><

command! SetWrap setl wrap | set ve=
command! SetWrapNo setl nowrap | set ve=all
command! SetExpandtab setl et sw=2 ts=2
command! SetExpandtabNo setl noet sw=4 ts=4

command! EditUtf8 set enc=utf8 | e! ++enc=utf8 ++ff=unix
command! EditCp932 set enc=cp932 | e! ++enc=cp932 ++ff=dos

command! GetYankFileName let @+ = expand('%:p:t') | echo @+
command! GetYankFileNameSimple let @+ = expand('%:p:t:r') | echo @+
command! GetYankFullPath let @+ = expand('%:p') | echo @+
command! GetYankDir let @+ = expand('%:p:h') | echo @+
command! GetYankTime let @+ = strftime('%Y%m%d_%H%M_') | echo @+

command! Bd bufdo bd!
command! -nargs=? -complete=file T tabe <args>
command! TA tab ball
command! MClear for n in range(200) | echom '' | endfor
command! CdCurrent if !empty(glob(expand('%:p:h')))|cd %:p:h|endif
command! -nargs=1 System exe 'CdCurrent'|echo system(<q-args>)

command! ClipToSlash let @+ = substitute(@+, '\\', '\/', 'g')
command! ClipToYen let @+ = substitute(@+, '\/', '\\', 'g')

command! GitStatus System git status
command! GitPull System git pull
command! GitCheckout exe join(['System', 'git', 'checkout', expand('%:p')])
command! GitAdd exe join(['System', 'git', 'add', expand('%:p')])
command! GitDiff System git diff
command! -nargs=+ GitCommit exe join(['System', 'git', 'commit', '-m', shellescape(<q-args>)])
command! GitPush System git push
command! -nargs=+ GitCommitThis exe join(['System', 'git', 'commit', expand('%:p'), '-m', shellescape(<q-args>)])

if g:Is_windows()
  command! ExCmd !start cmd
  command! ExSh !start sh --login -i
else
  if g:Is_mac()
    command! ExTerminal !open /Applications/Utilities/Terminal.app
  endif
  command! Wsudo w !sudo tee % > /dev/null
endif
"command! ShWebRootCh !. ~/.vim/sh/webroot_permission.sh
"}}}

"---------------------------------------------------------------------------
" vim script"{{{
cd ~
let g:debug = exists('g:debug') ? g:debug : 0
command! ToggleDebug let g:debug = g:debug ? 0 : 1
function! g:Echomsg(st_msg)
  if g:debug | echomsg a:st_msg | endif
endfunction

function! g:Debug_profile(cmd)
  cd ~
  profile start profile.log
  profile func *
  silent exe a:cmd
  qa!
endfunction

function! g:Index_increment()
  %s/\v(^\t*)@<=\d+/\=submatch(0)+1/ge
  "	for cnt in range(9,1,-1)
  "		exe '%s/\v(^\t*)@<='.cnt.'\.@=/'.expand(cnt+1).'/ge'
  "	endfo
endfunction

function! g:Index_decrement()
  %s/\v(^\t*)@<=\d+/\=submatch(0)-1/ge
endfunction

function! g:Index_increment_lines()
  g/./exe 'normal ' . (line('.')-1) . ''
endfunction

let g:conv_md_codetype = 'sh'
function! g:Conv_backlog_to_md()
  silent %s/\v^\*{3}\s?/### /ge
  silent %s/\v^\*{2}\s?/## /ge
  silent %s/\v^\*{1}\s?/# /ge
  silent %s/\v^\{code}/\='```' . g:conv_md_codetype/ge
  silent %s/\v^\{\/code}/```/ge
  silent %s/\v {1}$/  /ge
  silent %s/\v^\[\[/\[/ge
  silent %s/\v:/\]\(/ge
  silent %s/\v\]\]/\)/ge
endfunction

function! g:Conv_md_to_backlog()
  silent %s/\v^\#{3}\s?/*** /ge
  silent %s/\v^\#{2}\s?/** /ge
  silent %s/\v^\#{1}\s?/* /ge
  silent exe '%s/\v^```' . g:conv_md_codetype . '/{code}/ge'
  silent %s/\v^```/{\/code}/ge
  silent %s/\v {2}$/ /ge
  silent %s/\v^\[/\[\[/ge
  silent %s/\v\]\(/:/ge
  silent %s/\v\)/\]\]/ge
endfunction

function! g:Git_filter_branch()
  !git filter-branch -f --env-filter "GIT_AUTHOR_NAME='yakisuzu';GIT_AUTHOR_EMAIL='yakisuzu@gmail.com';GIT_COMMITTER_NAME='yakisuzu';GIT_COMMITTER_EMAIL='yakisuzu@gmail.com';" HEAD
endfunction

function! g:Update_tags(li_args)
  for st_arg in a:li_args
    if index(split(&tags, ','), st_arg) == -1
      let &tags .= ',' . st_arg
    endif
  endfor
endfunction

function! g:File_list(st_path)
  return sort(map(
        \ split(glob(a:st_path), '\n'),
        \ 'fnamemodify(v:val, ":t")'))
endfunction

function! g:Add_runtimepath(st_pkg)
  let st_path = g:dir_bundle . a:st_pkg . (match(a:st_pkg, '.*/$') == 0 ? '' : '/')
  let &runtimepath .= ',' . st_path

  let st_doc_path = st_path . 'doc'
  if !empty(glob(st_doc_path))
    exe 'helptags ' . st_doc_path
  endif
endfunction

function! g:Get_current_buf()
  return getbufline(bufnr('%'), 1, '$')
endfunction

function! g:Set_current_buf(li_buf)
  %d
  return setline(1, a:li_buf)
endfunction

function! g:Open_args(st_path, ...)
  if g:Is_windows()
    silent exe join(['!start', '"' . a:st_path . '"', join(a:000)])
  else
    echom 'not support'
  endif
endfunction

function! g:Call_python3(st_pyfile, ...)
  exe 'python3 import sys; sys.argv = [' . join(a:000, ',') . ']'
  exe 'py3file ' . a:st_pyfile
endfunction

function! g:Call_cscript(st_jsfile, ...)
  return system(join(['cscript', '//NoLogo', a:st_jsfile, join(a:000), '|ruby', '-ne', '"$_.encode!(%(UTF-8),%(Shift_JIS));puts $_"']))
endfunction
"}}}

