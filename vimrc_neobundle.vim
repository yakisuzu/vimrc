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
if !IsWindows()
	NeoBundle 'Shougo/vimproc'
	NeoBundle 'kakkyz81/evervim'
endif
NeoBundle 'Shougo/vimshell'
NeoBundle 'tpope/vim-fugitive'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

