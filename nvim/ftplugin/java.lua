local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
	vim.notify "JDTLS not found, install with `:LspInstall jdtls`"
	return
end


vim.api.nvim_command(':setlocal tabstop=4')
vim.api.nvim_command(':setlocal softtabstop=4')
vim.api.nvim_command(':setlocal shiftwidth=4')


local jdtls_dir = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local java_test_server_dir = vim.fn.stdpath('data') .. '/mason/packages/java-test/extension/server'
local java_debug_server_dir = vim.fn.stdpath('data') .. '/mason/packages/java-debug-adapter/extension/server'
local config_dir = jdtls_dir .. '/config_mac'
local plugins_dir = jdtls_dir .. '/plugins/'
local path_to_jar = plugins_dir .. 'org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar'
local path_to_lombok = jdtls_dir .. '/lombok.jar'

local root_markers = { "gradlew", "settings.gradle", "settings.gradle.kts", "build.gradle", "build.gradle.kts" }
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == "" then
	return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name
os.execute("mkdir " .. workspace_dir)


local config = {

	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		'java', -- or '/path/to/java17_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.
		-- '/Users/mihailiurco/.sdkman/candidates/java/current/bin/java'
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-javaagent:' .. path_to_lombok,
		'-Xmx1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
		'-jar', path_to_jar,
		'-configuration', config_dir,
		'-data', workspace_dir
	},

	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = root_dir,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			home = '/Users/mihailiurco/.sdkman/candidates/java/current',
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				runtimes = {
				}
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			format = {
				enabled = true,
				settings = {
					url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
		},
		signatureHelp = { enabled = true },
		completion = {
			enabled = true,
			favoriteStaticMembers = {
				"org.hamcrest.MatcherAssert.assertThat",
				"org.hamcrest.Matchers.*",
				"org.hamcrest.CoreMatchers.*",
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
				"java.util.Objects.requireNonNullElse",
				"org.mockito.Mockito.*",
			},
			importOrder = {
				"java",
				"javax",
				"com",
				"org"
			},
		},
		extendedClientCapabilities = extendedClientCapabilities,
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			useBlocks = true,
		},
	},

	flags = {
		allow_incremental_sync = true,
	},
	init_options = {
		bundles = {},
	},
}

config['on_attach'] = function(client, bufnr)
	require 'keymaps'.jdtls_keys(bufnr);
end


config['capabilities'] = require('cmp_nvim_lsp').default_capabilities()


local bundles = { vim.fn.glob(java_debug_server_dir .. '/com.microsoft.java.debug.plugin-*.jar', 1) }
vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_server_dir .. '/*.jar', 1), "\n"))

config['init_options'] = {
	bundles = bundles
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
