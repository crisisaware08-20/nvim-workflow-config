require("yanky").setup({
    highlight = {
        timer = 150,
    },
})

-- Use more relaxed highlight colors
vim.api.nvim_set_hl(0, "YankyPut", { bg = "DarkGrey" })
vim.api.nvim_set_hl(0, "YankyYanked", { bg = "DarkGrey" })


vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

-- Telescope picker for yank history
vim.keymap.set("n", "<leader>p", "<cmd>Telescope yank_history<cr>", { desc = "Yank history" })
