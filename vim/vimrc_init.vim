let g:dir_bundle = '~/.vim/bundle/'
let g:dir_home = '~/.vim/'

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')

function! g:Is_windows()
  return s:is_windows || s:is_cygwin
endfunction

function! g:Is_mac()
  return !g:Is_windows()
        \ && (
        \   has('mac')
        \   || has('macunix')
        \   || has('gui_macvim')
        \   || (
        \     !executable('xdg-open')
        \     && system('uname') =~? '^darwin'
        \   )
        \ )
endfunction

function! g:Vimrcadd_init()
  let st_localfile = fnamemodify('~/_vimrc_local', ':p')
  if empty(glob(st_localfile))
    call writefile([''], st_localfile)
  endif
endfunction

if has('vim_starting')
  let &runtimepath .= ',' . g:dir_home
  call g:Vimrcadd_init()
endif
