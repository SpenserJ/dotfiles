" This is the personal .vimrc file of Spenser Jones.
" Before you use any lines, be sure you understand what they do.
"
" You can find me at http://spenserj.com

" Vundle
  set nocompatible
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  " Load some bundles
  Plugin 'chriskempson/base16-vim'
  Plugin 'scrooloose/nerdcommenter'
  Plugin 'scrooloose/syntastic'
  Plugin 'raimondi/delimitmate'
  Plugin 'spf13/PIV'
  Plugin 'MarcWeber/vim-addon-mw-utils'
  Plugin 'tomtom/tlib_vim'
  Plugin 'garbas/vim-snipmate'
  Plugin 'majutsushi/tagbar'
  Plugin 'joonty/vdebug'
  Plugin 'bling/vim-airline'
  Plugin 'tpope/vim-fugitive'
  Plugin 'tpope/vim-haml'
  Plugin 'tpope/vim-surround'
  Plugin 'nathanaelkane/vim-indent-guides'
  Plugin 'pangloss/vim-javascript'
  Plugin 'airblade/vim-gitgutter'
  Plugin 'kien/ctrlp.vim'

  call vundle#end()

" Break up the vimrc into multiple files for clarity and organization
source ~/.vim/rc/environment.vimrc
source ~/.vim/rc/colorscheme.vimrc
source ~/.vim/rc/editor.vimrc
source ~/.vim/rc/keys.vimrc
source ~/.vim/rc/languages.vimrc
source ~/.vim/rc/color_overrides.vimrc
