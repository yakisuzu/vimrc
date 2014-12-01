"---------------------------------------------------------------------------
" 編集に関する設定:"{{{
" タブの画面上での幅 ts
set tabstop=4
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない) ws
set nowrapscan
"}}}

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:"{{{
" 行番号を非表示 (number:表示) nu
set number
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
set encoding=utf-8
" ファイル編集時に考慮される文字エンコーディングリスト fencs
set fileencodings+=cp932
" <EOL> を、カレントバッファについて設定する ff
set fileformat=unix
" ステータス行の表示内容を設定する stl
set statusline=%<%f\ %m%r%h%w%{'[enc='.&enc.'][ff='.&ff.']\ [fenc='.&fenc.'][ft='.&ft.']'}%=%l,%c%V%8P
"}}}

"---------------------------------------------------------------------------
" キーマップ追加"{{{
nnoremap <Esc><Esc> :nohlsearch<CR>
nnoremap <C-l> :checktime<CR><C-l>
nnoremap tg gT
nnoremap zl 20zl
nnoremap zh 20zh
nnoremap <Leader>h :tab<Space>h<Space><C-r><C-w><CR>
"}}}

"---------------------------------------------------------------------------
" 自動コマンド追加"{{{
" ファイルタイプ更新
augroup markdown
  autocmd!
  autocmd BufRead,BufNewFile *.md set nowrap
  autocmd BufWritePre *.md call s:writePre_md()

  function! s:writePre_md()
    silent %s/\v[^ ]@<= $/  /ge

    let regexList=[
          \ '^'
          \ ,'^---'
          \ ,'^```.*'
          \ ,' {2}'
          \ ,'^\|.+'
          \ ]

    let exeCom='v/\v('.join(regexList,'|').')$/normal A  '
    " echomsg exeCom
    silent exe exeCom
  endfunction
augroup END
"}}}

"---------------------------------------------------------------------------
" コマンド追加"{{{
command! -nargs=1 -complete=help H tab h <args>
command! -nargs=1 -complete=command RedirTab call g:Redir_tab(<q-args>)
command! -nargs=1 -complete=command DebugProfile call g:Debug_profile(<q-args>)
command! -nargs=1 ShTab call g:Sh_tab(<q-args>)

command! VimrcSo so ~/_vimrc
command! VimrcInit exe 'tabe '. g:dir_vimrc. 'vimrc_init.vim'
command! VimrcNeoBundle exe 'tabe '. g:dir_vimrc. 'vimrc_neobundle.vim'
command! VimrcBase exe 'tabe '. g:dir_vimrc. 'vimrc_base.vim'
command! VimrcAdd exe 'tabe '. g:dir_vimrc. 'vimrc_add.vim'
command! GVimrcSo so ~/_gvimrc
command! GVimrcBase exe 'tabe '. g:dir_vimrc. 'gvimrc_base.vim'

" ''(default):can move the cursor after the last character.
" all:Allow virtual editing in all modes.
command! -nargs=? SetVirtualEdit set virtualedit=<args>
command! -nargs=1 SetCo set columns+=<args>
command! -nargs=1 SetLines set lines+=<args>
command! -nargs=1 SetSpLinesUp normal <args>-
command! -nargs=1 SetSpLinesDown normal <args>+
command! -nargs=1 SetSpCoRight normal <args>>
command! -nargs=1 SetSpCoLeft normal <args><
command! SetIndentTab4 set noet sw=4
command! SetIndentSpace2 set et sw=2

command! SetEncUtf8 set encoding=utf-8
command! SetEncCp932 set encoding=cp932

command! GitPull echo system("git pull")
command! GitCheckout echo system("git checkout ".expand("%:p"))
command! GitAdd echo system("git add ".expand("%:p"))
command! -nargs=* GitCommit echo system("git commit ".expand("%:p")." -m ".shellescape(<q-args>))
command! GitPush echo system("git push")

command! Bd bufdo bd!
command! -nargs=? -complete=file T tabe <args>
command! MessageClear for n in range(200) | echom "" | endfor

command! Wsudo w !sudo tee % > /dev/null
command! ShWebRootCh !. ~/.vim/sh/webroot_permission.sh
"}}}

"---------------------------------------------------------------------------
" vim script"{{{
cd ~
let g:debug = expand('g:debug') ? g:debug : 0
command! ToggleDebug let g:debug = g:debug ? 0 : 1

function! g:Redir_tab(cmd)
  redir @*>
  silent execute a:cmd
  redir END
  tabe | normal Pgg
endfunction

function! g:Debug_profile(cmd)
  cd ~
  profile start profile.log
  profile func *
  silent exe a:cmd
  qa!
endfunction

function! g:Sh_tab(cmd)
  exe 'tabe | r!'.a:cmd
endfunction

function! g:S_clip()
  %s//\=@+/ge
endfunction

function! g:Index_increment()
  %s/\v(^\t*)@<=\d{1,}\.@=/\=submatch(0)+1/ge
  "	for cnt in range(9,1,-1)
  "		exe '%s/\v(^\t*)@<='.cnt.'\.@=/'.expand(cnt+1).'/ge'
  "	endfo
endfunction

function! g:Index_decrement()
  %s/\v(^\t*)@<=\d{1,}\.@=/\=submatch(0)-1/ge
endfunction

let g:conv_md_codetype = 'java'
function! g:Conv_backlog_to_md()
  %s/\v^\*{3}\s?/### /ge
  %s/\v^\*{2}\s?/## /ge
  %s/\v^\*{1}\s?/# /ge
  %s/\v^\{code}/\='```'.g:conv_md_codetype/ge
  %s/\v^\{\/code}/```/ge
  %s/\v {1}$/  /ge
endfunction

function! g:Conv_md_to_backlog()
  %s/\v^\#{3}\s?/*** /ge
  %s/\v^\#{2}\s?/** /ge
  %s/\v^\#{1}\s?/* /ge
  exe '%s/\v^```'.g:conv_md_codetype.'/{code}/ge'
  %s/\v^```/{\/code}/ge
  %s/\v {2}$/ /ge
endfunction

function! g:Git_filter_branch()
  !git filter-branch -f --env-filter "GIT_AUTHOR_NAME='yakisuzu';GIT_AUTHOR_EMAIL='yakisuzu@gmail.com';GIT_COMMITTER_NAME='yakisuzu';GIT_COMMITTER_EMAIL='yakisuzu@gmail.com';" HEAD
endfunction
"}}}

