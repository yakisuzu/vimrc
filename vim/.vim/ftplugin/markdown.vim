autocmd BufRead,BufNewFile *.md setlocal nowrap
autocmd BufWritePre *.md call s:writePre_md()

let s:markdown_add_suffix = 1
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
