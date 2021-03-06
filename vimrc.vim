" essential, makes good stuff work
set nocompatible

" if we can do syntax, do it,
if has('syntax') && (&t_Co > 2 || has("gui_running"))
  syntax on
endif

" what mode are we in? (all the time)
set showmode

" search options (makes sense over defaults)
set ignorecase
set smartcase
set incsearch

" make tab do real things (updated to make <Tab> insert \t)
inoremap <C-Tab> <C-T>
inoremap <S-Tab> <C-D>

" show stuff at the bottom right (commands as they are executed)
set showcmd

" ruler at the bottom
set ruler

" lots of history etc.
set history=1000
set undolevels=1000

" ignore shit
set wildignore=*.swp,*.bak,*.pyc,*.class

" terminal stuff (title,bell etc.)
set title
set visualbell
set noerrorbells

" activate clever stuff based on filetype
filetype on
filetype plugin on
filetype indent on

" some things for specific filetypes
autocmd filetype python set expandtab
autocmd filetype ruby set sw=2 expandtab
autocmd FileType yaml set sw=2 autoindent
" for formatting git edit messages:
autocmd FileType EDITMSG set formatoptions=tq textwidth=72

" eww extra files, no thanks.
set nobackup
set noswapfile

" go on then, we'll take mouse support, but only in insert mode
set mouse=i

" better colour scheme
colors pablo

" highlight search matches
set hlsearch

" funky shiz (autocomplete file name menu)
set wildmenu
set wildmode=list:longest,full

" dont close stuff, just hide it (dont have to save when editing new windows)
set hidden

" no wrapping lines thanks
set nowrap
" but we'll have hashes at the end of the line where we dont wrap.
set listchars=tab:»·,trail:·,extends:#,nbsp:·

" tabs are 4 spaces ffs.
set tabstop=4

" backspace over linebreaks etc.
set backspace=indent,eol,start

" work out how to do indenting using magic
set autoindent

" auto indent when pasting
set copyindent

" make tabs work like python (a bit)
set shiftwidth=4
set shiftround
set showmatch
set smarttab

" load magic filetype stuff
filetype on


" ;w instead of <shift>:w
nnoremap ; :

" clear search with ,/
nmap <silent> ,/ :let @/=""<CR>

" sudo to write
cmap w!! w !sudo tee % >/dev/null

" show the status bar
set laststatus=2

" faster terminals thanks
set ttyfast

" not sure how this was ever missed
set number
set relativenumber

" NSE scripts are actually LUA
:autocmd BufNewFile,BufRead *.nse set filetype=lua
"
" SLS files are YAML
:autocmd BufNewFile,BufRead *.sls set filetype=yaml

" magic line wrapping and make j/k go down a virtual line
set wrap
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Make Ctrl-e jump to the end of the current line in the insert mode. This is
" handy when you are in the middle of a line and would like to go to its end
" without switching to the normal mode.
inoremap <C-e> <C-o>$

set modelines=1
