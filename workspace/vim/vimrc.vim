" ==========================================================================================
"			Personal VIM configuration
" Author: Dmytro Malovanyi
" Description: VimRC file for Vim text editor
" Mapping:
"
" ==========================================================================================
"			Basic Configuration
" ==========================================================================================
" Set no compatible with vi compiler set nocompatible
set nocompatible

" TODO: Import color_scheme .vim file

" Set Leader prefix
let mapleader = ";"

" Set 256 colour compatiable
set t_Co=256

" Attemp to determine the type of file based on its name and possibly its
" contents. Use this to allow intelligent auto-indention for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
	filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
    syntax on
endif

" In many terminals emulators mouse working fine. Thus enable it.
if has('mouse')
	set mouse=a
	" fix mouse-drag to work in tmux/screen
	if &term =~ '^screen' || &term =~ 'xterm'
		" tmux knows the extended mouse mode
		if has("mouse_sgr")
			set ttymouse=sgr
		else
			set ttymouse=xterm2
		endif
	endif
endif

" Enable line numeration
set number
" Hide cursor while text typing
set mousehide
" Set more space for cmd messages box
set cmdheight=1
" Instead on errors on :e, :q, raise the confirmation window
set confirm
" Set UTF-8 encoding
set encoding=utf-8
" Set autoline indent
set autoindent
" Set smart line indent
set smartindent
" Set autocompletion command menu
set wildmenu
" Smart line breaks
set linebreak
" Set no backup (.swp) files
set nobackup
set nowritebackup
" Enable backspace to work properly
set backspace=indent,eol,start

" ------------------------------------
"  		Search settings
" ------------------------------------
" Set highlight search matching in Search mode
set hlsearch
" Set dynamic search (Each char will affect immediately)
set incsearch
" Set ignoring case while searching
set ignorecase
" Set smartcase search
set smartcase


" ------------------------------------
"  		Tabulation settings
" ------------------------------------
" Set appropriate number of spaces to insert in Insert mode
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" ------------------------------------
"  		Basic bindings
" ------------------------------------
" Map double ';;' to exit from Insert mode to normal
inoremap <leader>; <ESC>

" ---------------------------------------------------
"       Plugins
" ---------------------------------------------------

call plug#begin()

" VIM-Airline plugin to better bottom bar look and experience
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'

" Git plugin
Plug 'tpope/vim-fugitive'

" Nerd Tree
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Color scheme
Plug 'morhetz/gruvbox'

call plug#end()

" Load all configuration files
runtime! plugin_configs/**/*.vim

set background=dark
colorscheme gruvbox
