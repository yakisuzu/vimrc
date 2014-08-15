"---------------------------------------------------------------------------
" NeoBundle
"---------------------------------------------------------------------------
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
" Note: You don't set neobundle setting in .gvimrc!
" NeoBundle 'Shougo/vimproc'"{{{
if !neobundle#is_installed('vimproc')
	NeoBundle 'Shougo/vimproc', {
				\ 'build' : {
				\     'mac' : 'make -f make_mac.mak',
				\    },
				\ }
endif"}}}
if !IsWindows()
	NeoBundle 'kakkyz81/evervim'
endif
NeoBundle 'Shougo/vimshell'
NeoBundle 'tpope/vim-fugitive'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete.vim'
if neobundle#is_installed('neocomplete')
	" Use neocomplete.
	let g:neocomplete#enable_at_startup = 1
endif

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

