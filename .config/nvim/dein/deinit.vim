let s:deindir=$HOME . '/.config/nvim/dein'
let s:deinruntime=s:deindir . '/repos/github.com/Shougo/dein.vim'

if &compatible
  set nocompatible
endif
let &runtimepath=&runtimepath . ',' .  s:deinruntime

"if dein#load_state(s:deindir)
  call dein#begin(s:deindir)

  call dein#load_toml(s:deindir . '/dein.toml', {'lazy' : 0})
  call dein#load_toml(s:deindir . '/deinlazy.toml', {'lazy' : 1})

  call dein#end()
"  call dein#save_state()
"endif

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
