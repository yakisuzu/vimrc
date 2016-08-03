autocmd BufRead,BufNewFile *.java call s:bufRead_java()

" TODO loclistへ反映しても、ステータスに反映されない
autocmd BufWritePost,FilterWritePost,FileAppendPost,FileWritePost *.java call s:locMakeConv()

function! s:bufRead_java()
  if &fdm != 'diff'
    set fdm=syntax
  endif
  setl noet sw=4 ts=4
endfunction

function! s:locMakeConv()
  let loclist = getloclist(0)
  for i in loclist
    let i.text = iconv(i.text, 'cp932', &enc)
    echom i.text
  endfor
  call setloclist(0, loclist, 'r')
endfunction
