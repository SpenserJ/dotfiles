" Enable pathogen
execute pathogen#infect()

" Indentation
":set autoindent   " Match level
":set cindent      " Indent braces
:set shiftwidth=2 " Indent size
:set expandtab    " Spaces instead of tabs

" Word Wrap
":set wrap
":set linebreak
":set textwidth=80
":set wrapmargin=0

" syntastic
"let g:syntastic_enable_signs=1
"let g:syntastic_auto_loc_list=1

:nmap \l :setlocal number!<CR>
:nmap \o :set paste!<CR>

" Make j and k move a visual line instead of ful lline
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
