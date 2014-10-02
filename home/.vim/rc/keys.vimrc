" \o to toggle paste-mode
  :nmap \o :set paste!<CR>

" Don't move around the document with arrow keys!
  inoremap  <Up>     <NOP>
  inoremap  <Down>   <NOP>
  inoremap  <Left>   <NOP>
  inoremap  <Right>  <NOP>
  nnoremap  <Up>     <NOP>
  nnoremap  <Down>   <NOP>
  nnoremap  <Left>   <NOP>
  nnoremap  <Right>  <NOP>
  vnoremap  <Up>     <NOP>
  vnoremap  <Down>   <NOP>
  vnoremap  <Left>   <NOP>
  vnoremap  <Right>  <NOP>

" Disable Vim's crazy regex, and make it act like PRCE
  nnoremap / /\v
  vnoremap / /\v

" Disable the help key
  inoremap <F1> <NOP>
  nnoremap <F1> <NOP>
  vnoremap <F1> <NOP>
