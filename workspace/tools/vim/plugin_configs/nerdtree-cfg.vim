runtime plugged/nerdtree
" Map NERDTree Togle
nnoremap <C-q> :NERDTreeToggle<CR>

function! StartNERDTree()
    if exists('s:std_in')
        " Do not open NERD if file is open from std_in (vim -)
        return
    endif
    if argc() > 0
        " If Specified is directory ex. (vim .)
        if argc() == 1 && isdirectory(argv()[0])
            execute 'NERDTree' argv()[0]
            wincmd p
            enew
            execute 'cd '.argv()[0]
            wincmd p
        else
            NERDTree
            wincmd p
        endif
    else
        NERDTree
    endif
endfunction

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * call StartNERDTree()

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

autocmd CmdlineLeave * execute "normal \<C-w>_"
