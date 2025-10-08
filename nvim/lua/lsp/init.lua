-- Load individual LSP server configurations
require('lsp.clangd')
require('lsp.rust_analyzer')
require('lsp.lua_ls')

-- Enable all configured LSP servers
vim.lsp.enable({ 'clangd', 'rust_analyzer', 'lua_ls' })
