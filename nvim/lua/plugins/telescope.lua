local telescope = require('telescope')

telescope.setup({
  defaults = {
	  path_display = {"smart"}, -- or "smart", "shorten", "tail", "truncate"
    layout_config = {
      horizontal = {
        preview_width = 0.6,
      },
    },
  },
})

-- Load extensions
telescope.load_extension("yank_history")

-- Keymaps
vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { desc = 'Go to definition' })
vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { desc = 'Go to references' })
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep' })
