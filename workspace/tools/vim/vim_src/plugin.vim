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

" FZF
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

" Color scheme
Plug 'morhetz/gruvbox'
call plug#end()

" Load all configuration files
runtime! plugin_configs/**/*.vim
