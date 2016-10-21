" This is the personal .vimrc file of Spenser Jones.
" Before you use any lines, be sure you understand what they do.
"
" You can find me at http://spenserj.com

set nocompatible " No more vi compatibility

" Plug
  " Attempt to download vim-plug automatically
	if empty(glob('~/.vim/autoload/plug.vim'))
		silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall | source $MYVIMRC
	endif

  call plug#begin('~/.vim/bundle')

  " Load some bundles
    " Themes
    Plug 'chriskempson/base16-vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Linting
    " Plug 'scrooloose/syntastic'
    " Plug 'pmsorhaindo/syntastic-local-eslint.vim'
    Plug 'neomake/neomake'
    Plug 'benjie/neomake-local-eslint.vim'

    " Language Support
    Plug 'tpope/vim-haml'
    Plug 'lepture/vim-jinja'
    Plug 'PotatoesMaster/i3-vim-syntax'
    Plug 'pangloss/vim-javascript' | Plug 'mxw/vim-jsx'
    Plug 'elzr/vim-json'

    " Editor Upgrades
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'raimondi/delimitmate'
    Plug 'tpope/vim-surround'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'sjl/gundo.vim'

  call plug#end()

" Break up the vimrc into multiple files for clarity and organization
source ~/.vim/rc/environment.vimrc
source ~/.vim/rc/colorscheme.vimrc
source ~/.vim/rc/editor.vimrc
source ~/.vim/rc/keys.vimrc
source ~/.vim/rc/languages.vimrc
source ~/.vim/rc/color_overrides.vimrc
