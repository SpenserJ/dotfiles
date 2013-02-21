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

" pathogen
"call pathogen#infect()

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
