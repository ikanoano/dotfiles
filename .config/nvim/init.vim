" linue number
set number
set relativenumber
au TermOpen * setlocal nonumber norelativenumber
" status line
set laststatus=2
set cmdheight=1
set title
" indent
set cindent
set breakindent
" highlight
syntax enable
set nocursorline
set colorcolumn=80
" ()
set showmode
set showmatch
set matchtime=2
set matchpairs& matchpairs+=<:>
let b:match_ignorecase=0
" tab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
" space char
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,conceal:!
" For conceal markers.
let g:tex_conceal=''
set conceallevel=2 " concealcursor=niv
" search
set ignorecase
set smartcase
" encodings
scriptencoding utf-8
set encoding=utf-8
set fileencodings=utf-8,sjis,iso-2022-jp,euc-jp
set fileformats=unix,dos,mac
" others
set mouse=a
set foldmethod=marker
set background=light
set scrolloff=5
set inccommand=nosplit
let g:tex_flavor = "latex"
autocmd BufEnter term://* :startinsert
"set termguicolors
" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=1000
" auto close completion preview.
autocmd CompleteDone * pclose
set completeopt=menuone
" Force to save file when switching other file.
set nohidden
" clipboard
set clipboard=unnamed

" load plugins
runtime! ./dein/deinit.vim

" mapping
nnoremap ; :
nnoremap <S-h> ^
vnoremap <S-h> ^
onoremap <S-h> ^
nnoremap <S-l> $
vnoremap <S-l> $
onoremap <S-l> $
nmap <S-k> %
vmap <S-k> %
omap <S-k> %
nnoremap <Space> i<Space><Esc>l
nnoremap <Tab> i<Tab><Esc>l
vnoremap / <ESC>/\%V
vnoremap * "zy:let @/ = @z<CR>n
nnoremap <C-y> 2<C-y>
nnoremap <C-e> 2<C-e>
nnoremap <C-]> g<C-]>
nnoremap } }zz
nnoremap { {zz
nnoremap > >>
nnoremap < <<
nnoremap = ==
xnoremap > >gv
xnoremap < <gv
vnoremap <c-a> <c-a>gv
vnoremap <c-x> <c-x>gv
nnoremap x "_x
nnoremap ZZ  <Nop>

autocmd Filetype * set formatoptions-=r
autocmd Filetype * set formatoptions-=o
