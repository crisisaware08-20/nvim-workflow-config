return {

	-- Copilot and CopilotChat
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		opts = {},
		build = "make tiktoken", -- Only on MacOS or Linuxevent = "VeryLazy",
	},

	-- Table and DrawIt
	{
		"vim-scripts/DrawIt",
		"dhruvasagar/vim-table-mode",
	},

	-- Like IDE within terminal
	{
		"akinsho/toggleterm.nvim",
		lazy = false,
		version = "*",
		opts = {
			["open_mapping"] = [[<c-\>]],
		},
		direction = "vertical",
	},

	-- Folding
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Completion
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"rafamadriz/friendly-snippets",
			{ "L3MON4D3/LuaSnip", version = "v2.*" },
			-- "giuxtaposition/blink-cmp-copilot",
			"fang2hou/blink-copilot",
		},

		-- use a release tag to download pre-built binaries
		version = "*",

		opts_extend = { "sources.default" },
	},

	-- Color schemes
	{
		"folke/tokyonight.nvim",
		"ribru17/bamboo.nvim",
	},

	-- Git
	{
		"tpope/vim-fugitive",
		"lewis6991/gitsigns.nvim",
		"sindrets/diffview.nvim",
	},

	-- LSP servers, DAP servers, linters, and formatters
	-- Mason and nvim lsp integration
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"stevearc/conform.nvim",
		"zapling/mason-conform.nvim",
		"neovim/nvim-lspconfig",
	},

	-- Java lsp client wrapper
	{
		"mfussenegger/nvim-jdtls",
		dependencies = { "mfussenegger/nvim-dap" },
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
	},

	-- Status line
	{
		"famiu/feline.nvim",
	},

	-- Toggle comments
	{
		"terrortylor/nvim-comment",
	},

	-- Get lost with mapping ? Unload your mental model of mappings to this friendly plugin
	{
		"folke/which-key.nvim",
		lazy = true,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		dependencies = { "echasnovski/mini.nvim" },
	},

	-- Less distraction
	{
		"folke/zen-mode.nvim",
	},

	-- Auto pairs and surrounder
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"theHamsta/crazy-node-movement",
		},
	},

	-- Presentation tools
	{ "tjdevries/present.nvim" },
	{ "aspeddro/slides.nvim" },

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		-- stylua: ignore
		keys = {
			{ "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
			{ "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
			{ "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
			{ "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
		},
	},

	-- Markdown Preview
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},

{
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        -- your configuration here
      })
    end,
    -- Lazy-load on a key or event if desired; otherwise, it will load on require
    keys = { "<C-u>", "<C-d>" }, -- Example: lazy-load on these keys if you use them for scroll
    -- Or lazy-load on an event:
    -- event = "BufEnter",
  },
}
