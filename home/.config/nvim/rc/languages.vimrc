" Neomake
  let g:neomake_javascript_enabled_makers = ['eslint']
  autocmd bufnewfile,bufread *.jsx set filetype=javascript.jsx
  autocmd! BufReadPost,BufWritePost * Neomake
