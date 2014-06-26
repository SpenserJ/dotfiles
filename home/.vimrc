" This is the personal .vimrc file of Spenser Jones.
" Before you use any lines, be sure you understand what they do.
"
" You can find me at http://spenserjones.com

" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Load some bundles
Bundle 'chriskempson/base16-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'raimondi/delimitmate'
Bundle 'spf13/PIV'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'garbas/vim-snipmate'
Bundle 'majutsushi/tagbar'
Bundle 'joonty/vdebug'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-surround'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle "pangloss/vim-javascript"
Bundle 'airblade/vim-gitgutter'

" Environment
  " Save our swap and history files to ~/.vimdata, to keep the working dir clean
    set directory=~/.vimdata// " // at the end sets the filename to full path, to ensure uniqueness
    set undodir=~/.vimdata
    set undofile " Save our undo history to a file when writing a file - Saves to undodir

  filetype plugin on " Additional detection of filetypes
  set encoding=utf-8
  set ttyfast " We have a fast terminal connection, so send more at once

" UI
  " Colour Scheme
    colorscheme base16-default
    set background=dark
    set t_Co=256

  " Indent Guides
    let g:indent_guides_guide_size = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_enable_on_vim_startup = 1

  " Airline
    let g:airline_theme='solarized'
    let g:airline_powerline_fonts=1
    set noshowmode
    " Fix ttimeoutlen for exiting insert mode with Airline
    set ttimeoutlen=50

  set relativenumber " Default to relative lines being visible
  set showcmd " Show (partial) command information on the last line of the screen
  set ruler " Show the current line/column number in the bottom right
  set laststatus=2 " Always show the status line on the last window
  set colorcolumn=81 " Draw a line at column 85
  syntax enable " Syntax highlighting
  set scrolloff=3 " Scroll to retain lines above/below the current line
  set splitbelow " New splits should open below the current
  set splitright " New splits should open to the right of the current
  highlight SignColumn ctermbg=black
  highlight LineNr ctermfg=grey ctermbg=black

" Key (re)mapping
  " Leaders
      :nmap \l :setlocal number!<CR> " \l for lines
      :nmap \L :setlocal relativenumber!<CR> " \L for relative lines
      :nmap \o :set paste!<CR> " \o to toggle paste-mode

  " Don't move around the document with arrow keys!
    inoremap  <Up>     <NOP>
    inoremap  <Down>   <NOP>
    inoremap  <Left>   <NOP>
    inoremap  <Right>  <NOP>
    nnoremap  <Up>     <NOP>
    nnoremap  <Down>   <NOP>
    nnoremap  <Left>   <NOP>
    nnoremap  <Right>  <NOP>

  " Disable Vim's crazy regex, and make it act like PRCE
    nnoremap / /\v
    vnoremap / /\v

  " Disable the help key, since we're 1337 vim machines
    inoremap <F1> <NOP>
    nnoremap <F1> <NOP>
    vnoremap <F1> <NOP>

  inoremap jj <ESC> " Switch back to normal mode when typing jj
  map <F2> :NERDTreeToggle<CR> " NERDTree

" Workflow
  " Code folding
    " set foldmethod=indent
    " set foldlevel=0

  " Indentation
    set autoindent   " Match level
    set cindent      " Indent braces
    set tabstop=2 softtabstop=2 shiftwidth=2 expandtab " Indent size

  " Search
    set incsearch " Search should highlight as you type
    set hlsearch " Highlight all search results
    nnoremap <leader><space> :nohlsearch<cr> " Clear searches with <leader><space>

  " Command Autocompletion
    set wildmenu
    set wildmode=list:longest
    set backspace=indent,eol,start " Allow backspacing over indentation, line breaks, and the start of a line

" Plugins
  " Syntastic
    let g:syntastic_auto_loc_list=1
    let g:syntastic_check_on_open=1
    let g:syntastic_javascript_jshint_conf='~/.jshintrc'
    " Disable PHPCS unless run manually
    let g:syntastic_php_checkers = ['php']

  let NERDSpaceDelims=1

" Language Overrides
  if has("autocmd")
    " Drupal *.module and *.install files.
    augroup module
      autocmd BufRead,BufNewFile *.module  set filetype=php
      autocmd BufRead,BufNewFile *.install set filetype=php
      autocmd BufRead,BufNewFile *.test    set filetype=php
      autocmd BufRead,BufNewFile *.inc     set filetype=php
      autocmd BufRead,BufNewFile *.profile set filetype=php
      autocmd BufRead,BufNewFile *.view    set filetype=php
    augroup END
    " Bind/NSD3 *.zone
    autocmd BufRead,BufNewFile *.zone set filetype=bindzone
    autocmd FileType bindzone setlocal tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
  endif
