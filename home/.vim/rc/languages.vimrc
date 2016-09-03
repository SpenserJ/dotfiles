" Drupal *.module and *.install files.
  augroup drupal_files
    autocmd!
    autocmd BufRead,BufNewFile *.module  set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test    set filetype=php
    autocmd BufRead,BufNewFile *.inc     set filetype=php
    autocmd BufRead,BufNewFile *.profile set filetype=php
    autocmd BufRead,BufNewFile *.view    set filetype=php
  augroup END

" Bind/NSD3 *.zone
  augroup bind_files
    autocmd!
    autocmd BufRead,BufNewFile *.zone set filetype=bindzone
    autocmd FileType bindzone setlocal tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
  augroup END

" Syntastic
  let g:syntastic_auto_loc_list=1
  let g:syntastic_check_on_open=1
  let g:syntastic_javascript_checkers = ['eslint']
  let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
  let b:syntastic_javascript_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

" Code Folding for vimrc
  augroup vimrc_folding
    autocmd FileType vim setlocal foldmethod=indent
  augroup END
