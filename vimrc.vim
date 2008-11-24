if has('syntax') && (&t_Co > 2 || has("gui_running"))
  syntax on
endif
set backspace=indent,eol,start " allow backspace in insert mode
set mouse=a

set showmode 

autocmd FileType css set smartindent

set ignorecase
set smartcase
set incsearch

inoremap <Tab> <C-T>
inoremap <S-Tab> <C-D>

set showcmd
set ruler

set nocompatible

set mouse=a
colors evening
set hlsearch

set wildmenu

filetype on
autocmd FileType EDITMSG set formatoptions=tq textwidth=72
