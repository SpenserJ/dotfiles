" Neomake
  let g:neomake_javascript_enabled_makers = ['eslint']
  autocmd! BufReadPost,BufWritePost * Neomake
