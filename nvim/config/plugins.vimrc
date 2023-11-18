let g:rainbow_active = 1

" fuzzy finder
nnoremap ; :Files<CR>
nnoremap ' :Rg<CR>
nnoremap fb :Buffers<CR>
nnoremap fh :History:<CR>
nnoremap fl :Lines<CR>
nnoremap ft :Tags<CR>
nnoremap fw :Windows<CR>
nnoremap fm :Marks<CR>

"to cancel the window press C-G

nnoremap fc :Files ~/.config/nvim/config<CR>

let g:fzf_layout = { 'up': '~70%' }

let g:fzf_action = {
												\ 'ctrl-t': 'tab split',
												\ 'ctrl-x': 'split',
												\ 'ctrl-v': 'vsplit' }

let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_buffers_jump = 1

"vim-table-mode
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='
