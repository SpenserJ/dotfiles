" Save our swap and history files to ~/.vimdata, to keep the working dir clean
  set directory=~/.vimdata// " // at the end sets the filename to full path, to ensure uniqueness
  set undodir=~/.vimdata
  set undofile " Save our undo history to a file when writing a file - Saves to undodir

filetype plugin indent on " Additional detection of filetypes
set encoding=utf-8
set ttyfast " We have a fast terminal connection, so send more at once

" Airline
  set noshowmode
  " Fix ttimeoutlen for exiting insert mode with Airline
  set ttimeoutlen=50

" Watch ~/.vimrc and reload on change
augroup watchvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
