-- Load individual LSP server configurations
require('lsp.clangd')
require('lsp.rust_analyzer')
require('lsp.lua_ls')
require('lsp.kotlin_language_server')


-- Enable all configured LSP servers
vim.lsp.enable({ 'clangd', 'rust_analyzer', 'lua_ls', 'kotlin_language_server' })

-- Experimenting with Lua module: vim.lsp.log
-- vim.lsp.log.set_level 'trace'
-- require('vim.lsp.log').set_format_func(vim.inspect)

-- Then try to run the language server, and open the log with: >vim
--     :lua vim.cmd('tabnew ' .. vim.lsp.log.get_filename())


