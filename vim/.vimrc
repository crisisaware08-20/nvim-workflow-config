
set runtimepath+=$HOME/.local/share/nvim/site/autoload

" Load Plug.vim
if empty(glob('$HOME/.local/share/nvim/site/autoload'))
  echo "Plug.vim not found. Please check the path."
else
  source $HOME/.local/share/nvim/site/autoload/plug.vim
endif


call plug#begin()
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/DrawIt'
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
