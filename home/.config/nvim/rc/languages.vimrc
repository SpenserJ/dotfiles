" ALE
  function! GetYarnWorkspaceCwd(buffer) abort
    let l:nearest_package = ale#path#FindNearestFile(a:buffer, 'package.json')
    let l:project_dir = ale#path#Dirname(l:nearest_package)
    return !empty(l:project_dir) ? l:project_dir : ''
  endfunction

  function! GetYarnWorkspaceCommand(buffer) abort
    let l:options = ""

    return ale#node#Executable(a:buffer, 'yarn')
    \  . ' eslint'
    \  . (!empty(l:options) ? ' ' . l:options : '')
    \  . ' -f json --stdin --stdin-filename %s'
  endfunction

  call ale#linter#Define('javascript', {
  \  'name': 'yarn-eslint',
  \  'output_stream': 'both',
  \  'executable': 'yarn',
  \  'options': 'run eslint',
  \  'cwd': function('GetYarnWorkspaceCwd'),
  \  'command': function('GetYarnWorkspaceCommand'),
  \  'callback': 'ale#handlers#eslint#HandleJSON',
  \})

  call ale#linter#Define('typescript', {
  \  'name': 'yarn-eslint',
  \  'output_stream': 'both',
  \  'executable': 'yarn',
  \  'options': 'run eslint',
  \  'cwd': function('GetYarnWorkspaceCwd'),
  \  'command': function('GetYarnWorkspaceCommand'),
  \  'callback': 'ale#handlers#eslint#HandleJSON',
  \})
  
  let g:ale_linters = {
  \  'javascript': ['yarn-eslint'],
  \  'typescript': ['yarn-eslint'],
  \}
