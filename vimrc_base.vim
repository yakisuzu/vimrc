"---------------------------------------------------------------------------
" 編集に関する設定:
"---------------------------------------------------------------------------
" タブの画面上での幅 ts
set tabstop=4
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない) ws
set nowrapscan

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"---------------------------------------------------------------------------
" 行番号を非表示 (number:表示) nu
set number
" タブや改行を表示 (list:表示)
set list
" どの文字でタブや改行を表示するかを設定 lcs
set listchars=tab:>\ ,extends:<,trail:-,eol:$

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"---------------------------------------------------------------------------
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
set nobackup
" undoファイルを作成しない
set noundofile
" swapファイルを作成しない
set noswapfile

"---------------------------------------------------------------------------
" 追加
"---------------------------------------------------------------------------
" 無名レジスタのかわりにクリップボードレジスタ '*' を使用 cb
set clipboard=unnamed
" カーソルがある画面上の行をCursorLineで強調する|hl-CursorLine|。 cul
set cursorline
" タブページのラベルを表示 stal
set showtabline=2
" 隠れ状態にする hid
set hidden
" コマンドと検索の履歴数 hi
set history=500
" インデントに使われる空白の数 sw
set shiftwidth=4

"---------------------------------------------------------------------------
" キーマップ追加
"---------------------------------------------------------------------------
nnoremap <C-l> :nohlsearch<CR><C-l>
nnoremap tg gT

"—————————————————————————————————————
" 自動コマンド追加
"—————————————————————————————————————
" 透過度
if has('mac')
	set transparency=15
endif

"---------------------------------------------------------------------------
" コマンド追加
"---------------------------------------------------------------------------
command! -nargs=1 -complete=help H tab h <args>

command! VimrcBase tabe ~/vimrc/vimrc_base.vim
command! VimrcWSo w | so ~/vimrc/vimrc.vim
command! GVimrcBase tabe ~/vimrc/gvimrc_base.vim
command! GVimrcWSo w | so ~/vimrc/gvimrc.vim

command! -nargs=1 SetCo set columns+=<args>
command! -nargs=1 SetLines set lines+=<args>
command! -nargs=1 SetSpLinesUp normal <args>-
command! -nargs=1 SetSpLinesDown normal <args>+
command! -nargs=1 SetSpCoRight normal <args>>
command! -nargs=1 SetSpCoLeft normal <args><

command! Wsudo w !sudo tee % > /dev/null

command! TabeHttpd tabe /private/etc/apache2/httpd.conf

command! CdWebRoot cd /Library/WebServer/Documents/

command! ShWebRootCh !. ~/.vim/sh/webroot_permission.sh

