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
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Linting
    Plug 'neomake/neomake'
    Plug '~/src/local-npm-bin.vim'

    " Language Support
    Plug 'sheerun/vim-polyglot'
    Plug 'fatih/vim-go'

    " Editor Upgrades
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'raimondi/delimitmate'
    Plug 'tpope/vim-surround'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'sjl/gundo.vim'
    Plug 'jceb/vim-orgmode'
    Plug 'farseer90718/vim-taskwarrior'

  call plug#end()

" Break up the vimrc into multiple files for clarity and organization
source ~/.config/nvim/rc/environment.vimrc
source ~/.config/nvim/rc/colorscheme.vimrc
source ~/.config/nvim/rc/editor.vimrc
source ~/.config/nvim/rc/keys.vimrc
source ~/.config/nvim/rc/languages.vimrc
