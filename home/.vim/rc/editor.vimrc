" Line Numbers
  set relativenumber " Enable relative line numbers
  set number " Enable current line in absolute numbers
  " Disable relative numbers in insert mode, but enable in normal mode
    autocmd InsertEnter * :set relativenumber!
    autocmd InsertLeave * :set relativenumber

set showcmd " Show (partial) command information on the last line of the screen
set ruler " Show the current line/column number in the bottom right
set laststatus=2 " Always show the status line on the last window
set colorcolumn=81 " Draw a line at column 85
syntax enable " Syntax highlighting
set scrolloff=3 " Scroll to retain lines above/below the current line
set splitbelow " New splits should open below the current
set splitright " New splits should open to the right of the current

" Indent Guides
  let g:indent_guides_guide_size = 1
  let g:indent_guides_start_level = 2
  let g:indent_guides_enable_on_vim_startup = 1

" Indentation
  set autoindent   " Match level
  set cindent      " Indent braces
  set tabstop=2 softtabstop=2 shiftwidth=2 expandtab " Indent size

" Airline
  let g:airline#extensions#tabline#enabled = 1

" Search
  set incsearch " Search should highlight as you type
  set hlsearch " Highlight all search results
  nnoremap <leader><space> :nohlsearch<cr> " Clear searches with <leader><space>

" Command Line Completion
  set wildmenu
  set wildmode=list:longest

" Allow backspacing over indentation, line breaks, and the start of a line
  set backspace=indent,eol,start

" EasyMotion
  let g:EasyMotion_do_mapping = 0 " No default mappings
  nmap s <Plug>(easymotion-s2) " Bi-directional find motion

" Ctrl-P should search through the files ancestor path
  let g:ctrlp_working_path_mode = 'a'

" Place spaces after comment chars
  let NERDSpaceDelims=1
