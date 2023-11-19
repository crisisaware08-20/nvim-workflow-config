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
