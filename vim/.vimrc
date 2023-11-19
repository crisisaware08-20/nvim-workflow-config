
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
call plug#end()

set autoindent

set path+=$PWD/**/**
set dictionary+=$HOME/.vim/words/java_words
set clipboard=unnamedplus,unnamed,autoselect

set mouse=a
set number
set tabstop=2
set relativenumber

nmap <leader>sv :source ~/.vimrc<CR>
nmap <leader>ev :hide e ~/.vimrc<CR>

nmap <leard>f gg=G

:abbreviate ts <CR> @Test <CR> void test() { <CR> }<ESC><UP>o<TAB>

" window movement
nmap <Tab>j <c-w><s-j>
nmap <Tab>k <c-w><s-k>
nmap <Tab>h <c-w><s-h>
nmap <Tab>l <c-w><s-l>
