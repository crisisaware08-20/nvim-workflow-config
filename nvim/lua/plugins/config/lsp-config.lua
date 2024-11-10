require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup {
	ensure_installed = { "lua_ls", "bashls", "ts_ls", "groovyls", "gradle_ls" }
}

-- Automatically setup LSP servers for all installed servers
require("mason-lspconfig").setup_handlers {
	-- Default handler for all servers
	function(server_name)
		require("lspconfig")[server_name].setup {}
	end,
	-- Custom handler for bashls
	-- ["bashls"] = function()
	-- 	require("lspconfig").bashls.setup {
	-- 		filetypes = { "zsh", "sh" }
	-- 	}
	-- end
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		-- underline = false, -- This will disable underline for all diagnostics sent from LSP
		underline = {
			severity = vim.diagnostic.severity.ERROR, -- show underline for errors only
		},
		signs = true,
		virtual_text = false,
		-- Enable virtual text for errors only, this is too noisy
		virtual_text = {
			severity = vim.diagnostic.severity.ERROR,
		},
	}
)

-- Configure the LSP server with nvim-lspconfig
-- Note: nvim-lspconfig does not install language servers for you. It can be installed manually or could be installed by mason plugin
-- 
--
--
-- local lspconfig = require('lspconfig')
-- lspconfig.rust_analyzer.setup {
--   -- Server-specific settings. See `:help lspconfig-setup`
--   settings = {
--     ['rust-analyzer'] = {},
--   },
-- }
--
--
-- lspconfig.groovyls.setup {}
--
--
-- lspconfig.gradle_ls.setup {
-- 	cmd = { "gradle-language-server" },
-- 	init_options = {
-- 		settings = {
-- 			gradleWrapperEnabled = false
-- 		}
-- 	}
-- }
