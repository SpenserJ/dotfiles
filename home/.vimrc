" Enable pathogen
execute pathogen#infect()

" Indentation
:set autoindent   " Match level
:set cindent      " Indent braces
:set tabstop=2 softtabstop=2 shiftwidth=2 expandtab " Indent size

" Indent Guides
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1


" Word Wrap
":set wrap
":set linebreak
":set textwidth=80
":set wrapmargin=0

" syntastic
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1

:nmap \l :setlocal number!<CR>
:nmap \o :set paste!<CR>

" Make j and k move a visual line instead of full line
:nmap j gj
:nmap k gk

" Search should highlight as you type
:set incsearch

" Don't move around the document with arrow keys!
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
nnoremap  <Up>     <NOP>
nnoremap  <Down>   <NOP>
nnoremap  <Left>   <NOP>
nnoremap  <Right>  <NOP>

" Enable Solarized
syntax enable
let g:solarized_termtrans = 1
colorscheme solarized
set background=light

" NERDTree
map <F2> :NERDTreeToggle<CR>
