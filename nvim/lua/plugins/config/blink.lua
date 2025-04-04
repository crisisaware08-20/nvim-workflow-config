require('blink.cmp').setup({
	cmdline = { completion = { menu = { auto_show = true } } },
	snippets = { preset = 'luasnip' },
	-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
	-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
	-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
	--
	-- All presets have the following mappings:
	-- C-space: Open menu or open docs if already open
	-- C-e: Hide menu
	-- C-k: Toggle signature help
	--
	-- See the full "keymap" documentation for information on defining your own keymap.
	keymap = { preset = 'default' },

	appearance = {
		-- Sets the fallback highlight groups to nvim-cmp's highlight groups
		-- Useful for when your theme doesn't support blink.cmp
		-- Will be removed in a future release
		use_nvim_cmp_as_default = true,
		-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = 'mono',

		-- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
		kind_icons = {
			Copilot = "",
			Text = '󰉿',
			Method = '󰊕',
			Function = '󰊕',
			Constructor = '󰒓',

			Field = '󰜢',
			Variable = '󰆦',
			Property = '󰖷',

			Class = '󱡠',
			Interface = '󱡠',
			Struct = '󱡠',
			Module = '󰅩',

			Unit = '󰪚',
			Value = '󰦨',
			Enum = '󰦨',
			EnumMember = '󰦨',

			Keyword = '󰻾',
			Constant = '󰏿',

			Snippet = '󱄽',
			Color = '󰏘',
			File = '󰈔',
			Reference = '󰬲',
			Folder = '󰉋',
			Event = '󱐋',
			Operator = '󰪚',
			TypeParameter = '󰬛',

		},
	},

	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = { 'lsp', 'snippets', 'buffer', 'path'  },
		-- default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
		-- default = { 'lsp', 'path', 'buffer' },
		providers = {
			copilot = {
				name = "copilot",
				-- module = "blink-cmp-copilot",
				module = "blink-copilot",
				score_offset = 100,
				async = true,
			},
		},
	},

	-- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
	-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
	-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
	--
	-- See the fuzzy documentation for more information
	fuzzy = { implementation = "prefer_rust_with_warning" },
})
