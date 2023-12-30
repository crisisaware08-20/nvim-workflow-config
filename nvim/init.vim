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
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/DrawIt'
call plug#end()


" Automatically save the buffer when it loses focus or goes into hidden state
autocmd BufLeave * silent! wall


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


source $HOME/.config/nvim/config/plugins.vimrc
source $HOME/.config/nvim/config/basic_mappings.vimrc
source $HOME/.config/nvim/config/basic_options.vimrc

au FocusLost * :wa
