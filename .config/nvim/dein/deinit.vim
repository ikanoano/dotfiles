let s:deindir=$HOME . '/.config/nvim/dein'
let s:deinruntime=s:deindir . '/repos/github.com/Shougo/dein.vim'

if &compatible
  set nocompatible
endif

"" Required:
let &runtimepath=&runtimepath . ',' .  s:deinruntime
call dein#begin(s:deindir)

" Load my plugins
call dein#load_toml(s:deindir . '/dein.toml', {'lazy' : 0})

" Required:
call dein#end()

" If you want to install not installed plugins on startup.
if dein#check_install()
 call dein#install()
endif

if dein#tap('gruvbox')
  colorscheme gruvbox
  let g:lightline = {
        \ 'colorscheme': 'gruvbox',
        \ 'active': {
        \   'left': [ ['mode', 'paste'],
        \             ['readonly', 'filename', 'modified', 'taginfo'] ]
        \ },
        \ 'component': {
        \   'lineinfo': ' %3l:%-2v'
        \ },
        \ 'component_function': {
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive'
        \ },
        \ 'separator': { 'left': '', 'right': '' },
        \ 'subseparator': { 'left': '', 'right': '' }
        \ }
  function! LightlineReadonly()
    return &readonly ? '' : ''
  endfunction
  function! LightlineFugitive()
    if exists('*fugitive#head')
      let branch = fugitive#head()
      return branch !=# '' ? ''.branch : ''
    endif
    return ''
  endfunction
endif

filetype plugin indent on
syntax enable
