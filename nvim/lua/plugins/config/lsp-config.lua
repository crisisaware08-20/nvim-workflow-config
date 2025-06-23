require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = { "lua_ls", "bashls", "ts_ls" }
}

-- vim.lsp.set_log_level("debug")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		-- underline = false, -- This will disable underline for all diagnostics sent from LSP
		underline = {
			severity = vim.diagnostic.severity.ERROR, -- show underline for errors only
		},
		signs = true,
		virtual_text = false,
		-- Enable virtual text for errors only, this is too noisy
		-- virtual_text = {
		-- 	severity = vim.diagnostic.severity.ERROR,
		-- },
	}
)

-- Configure the LSP server with nvim-lspconfig
-- Note: nvim-lspconfig does not install language servers for you. It can be installed manually or could be installed by mason plugin
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
--


-- It should be set per each added lsp otherwise lsp server will not know what lsp client is capable of
-- lsp_server --> lsp_client --> blink
local capabilities = require('blink.cmp').get_lsp_capabilities()

require("lspconfig").lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Use LuaJIT in Neovim
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Recognize `vim` as a global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false, -- Disable telemetry
			},
		},
	},
	on_attach = function(client, bufnr)
		print('Lua Lsp Client attaching to buffer')
		local lsp_keys = require('keymaps').lsp_keys()
		require('util-module').set_keymaps(bufnr, lsp_keys)
	end,
})
