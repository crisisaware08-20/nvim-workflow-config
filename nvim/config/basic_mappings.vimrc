" Key Mappings:Customized keys

nmap <leader>w :Explore<CR>

nmap <leader>b :buffers<CR>:buffer<space>


"Close window
nnoremap qw :q <CR>

"Set file's current directory as current working directory
nnoremap <leader>cd :cd %:p:h<cr>

"Go to home and end using capitalized directions
noremap H 0
noremap L $

"Yank by the end of line not including the new line character
noremap Y y$

"0 to first non-blank character
noremap 0 ^

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz

"Use 't/T' to move among tabs
noremap t :tabn<CR>
noremap T :tabp<CR>

"Select all
noremap <Leader>sa ggVG

vnoremap J :m '>+1<CR>gv=gv
"Move visual block
vnoremap K :m '<-2<CR>gv=gv

"Keep visual block selected, so that you could continue indenting
vnoremap < <gv
vnoremap > >gv

"Edit vimrc and zshrc
nnoremap <leader>ez :vsplit $HOME/.zshrc<cr>
nnoremap <leader>sz :source $HOME/.zshrc<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"Movement between windows
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k

"Split window
nnoremap <Space>v :vsplit<CR>
nnoremap <Space>h :split<CR>

"Increases/Decrease window width/height
nnoremap <Space> 4<c-w>>
nnoremap <Tab> 4<c-w><
nnoremap <CR> 4<c-w>>
nnoremap <S-Up> 3<c-w>+
nnoremap <S-Down> 3<c-w>-
nnoremap <Space>f <c-w>o

"Moving windows
nnoremap <Tab>h <C-W>H
nnoremap <Tab>l <C-W>L
nnoremap <Tab>j <C-W>J
nnoremap <Tab>k <C-W>K
nnoremap <Tab>t <C-W>T

nnoremap <C-e> 3<c-e>
nnoremap <C-y> 3<c-y>

"Indent the content of the file
nnoremap <Leader>f gg=G 
