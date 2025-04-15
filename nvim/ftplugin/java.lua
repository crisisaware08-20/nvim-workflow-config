local jdtls_settings = {
	java = {
		home = "/Users/mihailiurco/.sdkman/candidates/java/current",
	},
}

require("jdtls").jol_path = os.getenv("HOME") .. "/java_tools/jol-cli-0.17-full.jar"

local client_capabilities_config = require("blink.cmp").get_lsp_capabilities()
-- This is not required anymore as the blink.cmp.get_lsp_capabilities() overrides this value with true
-- client_capabilities_config.textDocument.completion.completionItem.snippetSupport = true

-- Define the root directory dynamically
local root_dir =
	vim.fs.dirname(vim.fs.find({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }, { upward = true })[1])
if not root_dir then
	vim.notify("No valid Java root directory found !", vim.log.levels.ERROR)
	return
end

local java_test_path = require("mason-registry").get_package("java-test"):get_install_path()
local java_debug_path = require("mason-registry").get_package("java-debug-adapter"):get_install_path()
local lombok_path = vim.fn.stdpath("data") .. "/lombok/lombok.jar"
local bundles = {
	vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n"))

-- curl -fLo ~/.local/share/nvim/lombok/lombok.jar --create-dirs https://projectlombok.org/downloads/lombok.jar
if vim.fn.filereadable(lombok_path) == 0 then
	vim.fn.mkdir(vim.fn.stdpath("data") .. "/lombok", "p")
	vim.fn.system({
		"curl",
		"-fLo",
		vim.fn.stdpath("data") .. "/lombok/lombok.jar",
		"--create-dirs",
		"https://projectlombok.org/downloads/lombok.jar",
	})
end

local jdtls_path = require("mason-registry").get_package("jdtls"):get_install_path()
local config = {

	cmd = {
		jdtls_path .. "/bin/jdtls",
		"-data",
		vim.fn.stdpath("data") .. "/jdtls_workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t"), -- Workspace per project
		"--jvm-arg=-javaagent:" .. lombok_path,
	},

	root_dir = root_dir,
	on_attach = function(client, bufnr)
		print("Attaching to the java buffer, relevant keymaps will be set")
		local jdtls_keys = require("keymaps").jdtls_keys()
		require("util-module").set_keymaps(bufnr, jdtls_keys)
	end,
	settings = jdtls_settings,
	capabilities = client_capabilities_config,
	init_options = {
		bundles = bundles, -- Add debug/test bundles if needed
	},
}

require("jdtls").start_or_attach(config)
