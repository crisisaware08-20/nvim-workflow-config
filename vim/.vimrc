
"let g:vim_configuration_dir = $HOME . '<vim_config_repo_directory>'
let g:vim_configuration_dir = $HOME . '/vim-configuration'


" Add the vim configuration to the runtimepath
if isdirectory(g:vim_configuration_dir)
				execute 'set runtimepath+=' . g:vim_configuration_dir . '/autoload'
else
				echom "Vim configuration directory does not exists: " . g:vim_configuration_dir
endif

" Load plug vim
if empty(glob(g:vim_configuration_dir . '/autoload'))
				echo "Plug.vim not found. Please check the path."
else
				execute 'source ' . g:vim_configuration_dir . '/autoload/plug.vim'
endif

call plug#begin()
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/DrawIt'
Plug 'maksimr/vim-beautify'
Plug 'prabirshrestha/vim-lsp'
call plug#end()

set autoindent

set path+=$PWD/**/**
set dictionary+=$HOME/.vim/words/java_words
set clipboard=unnamedplus,unnamed,autoselect
set hidden

set mouse=a
set number
set relativenumber
set tabstop=2
set shiftwidth=1
set noswapfile

nmap <leader>sv :source ~/.vimrc<CR>
nmap <leader>ev :hide e ~/.vimrc<CR>
nmap <leader>sz :!source ~/.zshrc<CR>
nmap <leader>ez :hide e ~/.zshrc<CR>

nmap <leader>f gg=G
" To ident the current line ==
" To ident the all the lines below the current line
" To ident n lines below the current line n==
" To ident block of code, go to one of the braces and use command =%

:abbreviate ts <CR> @Test <CR> void test() { <CR> }<ESC><UP>o<TAB>

" window movement
nmap <Tab>j <c-w><s-j>
nmap <Tab>k <c-w><s-k>
nmap <Tab>h <c-w><s-h>
nmap <Tab>l <c-w><s-l>

nmap <leader>w :Explore<CR>


" Automatically save the buffer when it loses focus or goes into hidden state
autocmd BufLeave * silent! wall

nmap <leader>b :buffers<CR>:buffer<space>

" Toggle in and out of terminal mode
nnoremap <Leader>t :call ToggleTerminal()<CR>
tnoremap <Esc> <C-\><C-n>

function! ToggleTerminal()
  if &buftype ==# 'terminal'
    " If in terminal mode, close the terminal
    call term_sendkeys(bufnr(''), "\<C-w>:q\<CR>")
  else
    " If not in terminal mode, open a new terminal
    term
  endif
endfunction
