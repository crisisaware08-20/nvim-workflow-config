local lspconfig = require 'lspconfig'
local mlspconfig = require('mason-lspconfig')

require('mason').setup()
mlspconfig.setup {
	ensure_installed = { "lua_ls", "bashls", "tsserver", "groovyls", "gradle_ls" }
}

-- lspconfig.groovyls.setup {}

-- lspconfig.gradle_ls.setup {
-- 	cmd = { "gradle-language-server" },
-- 	init_options = {
-- 		settings = {
-- 			gradleWrapperEnabled = false
-- 		}
-- 	}
-- }

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		-- Disable underline for warnings
		underline = {
			severity_limit = "Error",
		},
		-- Show signs for warnings
		signs = true,
		-- Enable virtual text for errors only
		virtual_text = {
			severity_limit = "Error",
		},
	}
)

lspconfig.bashls.setup {
	filetypes = { "zsh", "sh" }
}

lspconfig.lua_ls.setup {
	filetypes = { "lua" },
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
			client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = 'LuaJIT'
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME
							-- Depending on the usage, you might want to add additional paths here.
							-- E.g.: For using `vim.*` functions, add vim.env.VIMRUNTIME/lua.
							-- "${3rd}/luv/library"
							-- "${3rd}/busted/library",
						}
						-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
						-- library = vim.api.nvim_get_runtime_file("", true)
					}
				}
			})
		end
		return true
	end
}
