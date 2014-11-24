"---------------------------------------------------------------------------
" ウインドウに関する設定:
"---------------------------------------------------------------------------
" ウインドウの幅
set columns=200
" ウインドウの高さ
set lines=40
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
colorscheme evening " (GUI使用時)

" 透過度
if IsWindows()
  autocmd GUIenter * set transparency=190
endif
if IsMac()
  set transparency=15
endif

" guiの挙動を変更 go
set guioptions-=m
set guioptions-=T
set guioptions+=b
set guioptions+=h

"augroup highlightCr
"  autocmd!
"  autocmd ColorScheme * highlight HiCr term=underline ctermbg=DarkGreen guibg=DarkGreen
"  autocmd BufWinEnter * match HiCr /\r/
"augroup END

