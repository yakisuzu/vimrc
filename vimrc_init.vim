let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')

function! IsWindows()
	return s:is_windows
endfunction

function! IsMac()
	return !s:is_windows && !s:is_cygwin
				\ && (has('mac') || has('macunix') || has('gui_macvim') ||
				\ (!executable('xdg-open') &&
				\ system('uname') =~? '^darwin'))
endfunction

