local M = {}


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

function M.setup()

	-- Define the root directory dynamically
	local root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }, { upward = true })[1])
	if not root_dir then
		vim.notify("No valid Java root directory found", vim.log.levels.ERROR)
		return
	end


	-- Path to the jdtls binary (from Mason)
	local jdtls_path = require("mason-registry").get_package("jdtls"):get_install_path()
end

return M
