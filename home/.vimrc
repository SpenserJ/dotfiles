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
  Plugin 'MarcWeber/vim-addon-mw-utils'
  Plugin 'tomtom/tlib_vim'
  Plugin 'garbas/vim-snipmate'
  Plugin 'majutsushi/tagbar'
  Plugin 'joonty/vdebug'
  Plugin 'bling/vim-airline'
  Plugin 'tpope/vim-fugitive'
  Plugin 'tpope/vim-haml'
  Plugin 'tpope/vim-surround'
  Plugin 'pangloss/vim-javascript'
  Plugin 'airblade/vim-gitgutter'
  Plugin 'kien/ctrlp.vim'
  Plugin 'lepture/vim-jinja'
  Plugin 'whatyouhide/vim-gotham'
  Plugin 'git://drupalcode.org/project/vimrc.git', { 'rtp': 'bundle/vim-plugin-for-drupal/' }
  Plugin 'shawncplus/phpcomplete.vim'
  Plugin 'ervandew/supertab'

  call vundle#end()

" Break up the vimrc into multiple files for clarity and organization
source ~/.vim/rc/environment.vimrc
source ~/.vim/rc/colorscheme.vimrc
source ~/.vim/rc/editor.vimrc
source ~/.vim/rc/keys.vimrc
source ~/.vim/rc/languages.vimrc
source ~/.vim/rc/color_overrides.vimrc
