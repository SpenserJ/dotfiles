runtime plugin/neomake-local-eslint.vim
" Neoformat typescript exes

let b:neomake_typescript_eslint_exe = GetNpmBin('eslint')

let g:neomake_typescript_yarn_eslint_maker = {
    \ 'exe': '/home/spenser/.nvm/versions/node/v12.18.3/bin/yarn',
    \ 'args': ['run', 'eslint', '--format=compact'],
    \ 'cwd': '%:p:h',
    \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,%W%f: line %l\, col %c\, Warning - %m,%-G,%-G%*\d problems%#'
    \ }
let g:neomake_typescript_enabled_makers = ['yarn_eslint']

if exists('g:neoformat_enabled_typescript') && index(g:neoformat_enabled_typescript, 'tsfmt') >= 0
  if ! exists('b:neoformat_typescript_tsfmt')
    if exists('g:neoformat_typescript_tsfmt')
      let b:neoformat_typescript_tsfmt = g:neoformat_typescript_tsfmt
    else
      let b:neoformat_typescript_tsfmt = neoformat#formatters#typescript#tsfmt()
    endif
  endif
  let b:neoformat_typescript_tsfmt.exe = GetNpmBin('tsfmt')
endif

if exists('g:neoformat_enabled_typescript') && index(g:neoformat_enabled_typescript, 'prettier') >= 0
  if ! exists('b:neoformat_typescript_prettier')
    if exists('g:neoformat_typescript_prettier')
      let b:neoformat_typescript_prettier = g:neoformat_typescript_prettier
    else
      let b:neoformat_typescript_prettier = neoformat#formatters#typescript#prettier()
    endif
  endif
  let b:neoformat_typescript_prettier.exe = GetNpmBin('prettier')
endif

if exists('g:neoformat_enabled_typescript') && index(g:neoformat_enabled_typescript, 'eslint_d') >= 0
  if ! exists('b:neoformat_typescript_eslint_d')
    if exists('g:neoformat_typescript_eslint_d')
      let b:neoformat_typescript_eslint_d = g:neoformat_typescript_eslint_d
    else
      let b:neoformat_typescript_eslint_d = neoformat#formatters#typescript#eslint_d()
    endif
  endif
  let b:neoformat_typescript_eslint_d.exe = GetNpmBin('eslint_d')
endif
