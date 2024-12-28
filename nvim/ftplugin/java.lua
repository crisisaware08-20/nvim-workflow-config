local jdtls_settings = {
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
}

-- Capabilities, so far enabling snippet support without which the confirmation of a method will not provide the method parameters
local client_capabilities_config = vim.lsp.protocol.make_client_capabilities()
client_capabilities_config.textDocument.completion.completionItem.snippetSupport = true


-- Define the root directory dynamically
local root_dir = vim.fs.dirname(vim.fs.find(
	{ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
	{ upward = true })[1])
if not root_dir then
	vim.notify("No valid Java root directory found !", vim.log.levels.ERROR)
	return
end

local java_test_path = require("mason-registry").get_package("java-test"):get_install_path()
local java_debug_path = require("mason-registry").get_package("java-debug-adapter"):get_install_path()
local lombok_path = vim.fn.stdpath("data") .. "/lombok/lombok.jar"
local bundles = {
	vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar")
}
vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n"))

-- curl -fLo ~/.local/share/nvim/lombok/lombok.jar --create-dirs https://projectlombok.org/downloads/lombok.jar

if (vim.fn.filereadable(lombok_path) == 0) then
	vim.fn.mkdir(vim.fn.stdpath("data") .. "/lombok", "p")
	vim.fn.system({
		"curl",
		"-fLo",
		vim.fn.stdpath("data") .. "/lombok/lombok.jar",
		"--create-dirs",
		"https://projectlombok.org/downloads/lombok.jar"
	})
end


-- Another way to start jdtls

-- local jdtls_dir = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
-- local java_test_server_dir = vim.fn.stdpath('data') .. '/mason/packages/java-test/extension/server'
-- local java_debug_server_dir = vim.fn.stdpath('data') .. '/mason/packages/java-debug-adapter/extension/server'
-- local config_dir = jdtls_dir .. '/config_mac'
-- local plugins_dir = jdtls_dir .. '/plugins/'
-- local path_to_jar = plugins_dir .. 'org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar'
-- local path_to_lombok = jdtls_dir .. '/lombok.jar'
-- local alternative_cmd = {
-- 	'java', -- or '/path/to/java17_or_newer/bin/java'
-- 	-- depends on if `java` is in your $PATH env variable and if it points to the right version.
-- 	-- '/Users/mihailiurco/.sdkman/candidates/java/current/bin/java'
-- 	'-Declipse.application=org.eclipse.jdt.ls.core.id1',
-- 	'-Dosgi.bundles.defaultStartLevel=4',
-- 	'-Declipse.product=org.eclipse.jdt.ls.core.product',
-- 	'-Dlog.protocol=true',
-- 	'-Dlog.level=ALL',
-- 	'-javaagent:' .. path_to_lombok,
-- 	'-Xmx1g',
-- 	'--add-modules=ALL-SYSTEM',
-- 	'--add-opens', 'java.base/java.util=ALL-UNNAMED',
-- 	'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
-- 	'-jar', path_to_jar,
-- 	'-configuration', config_dir,
-- 	'-data', vim.fn.stdpath("data") .. "/jdtls_workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
-- }


-- Path to the jdtls binary (from Mason)
local jdtls_path = require("mason-registry").get_package("jdtls"):get_install_path()
local config = {

	-- "-javaagent:/Users/mihailiurco/.local/share/nvim/lombok/lombok.jar"

	cmd = {
		jdtls_path .. "/bin/jdtls",
		"-data", vim.fn.stdpath("data") .. "/jdtls_workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t"), -- Workspace per project
		"--jvm-arg=-javaagent:" .. lombok_path,

	},
	-- cmd = cmd_1,
	root_dir = root_dir,
	on_attach = function(client, bufnr)
		print('Attaching to the java buffer, relevant keymaps will be set')
		local jdtls_keys = require('keymaps').jdtls_keys()
		require('util-module').set_keymaps(bufnr, jdtls_keys)
	end,
	settings = jdtls_settings,
	capabilities = client_capabilities_config,
	init_options = {
		bundles = bundles, -- Add debug/test bundles if needed
	},
}

require('jdtls').start_or_attach(config)
