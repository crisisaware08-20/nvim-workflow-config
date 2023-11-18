set runtimepath+=$HOME/vimnvimconfig/autoload/

source $HOME/vimnvimconfig/autoload/plug.vim

call plug#begin()
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/DrawIt'
Plug 'reedes/vim-pencil'
Plug 'frazrepo/vim-rainbow'
Plug 'dhruvasagar/vim-table-mode'
Plug 'sainnhe/edge'
Plug 'sainnhe/edge'
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-jdtls'
call plug#end()

source $HOME/.config/nvim/config/plugins.vimrc
source $HOME/.config/nvim/config/basic_mappings.vimrc
source $HOME/.config/nvim/config/basic_options.vimrc
source $HOME/.config/nvim/config/terminall.vimrc

au FocusLost * :wa
