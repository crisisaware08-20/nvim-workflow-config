require("blink.cmp").setup({
	completion = {
		-- check the documentation for additional configurations
		-- https://cmp.saghen.dev/configuration/reference.html#completion-accept
		accept = {},
		trigger = {
			-- Shows after typing a keyword, typically an alphanumeric character, `-` or `_`
			show_on_keyword = true,
			-- Shows after typing a trigger character, defined by the sources. For example for Luar or Rust, the LSP will define . as a trigger character.
			show_on_trigger_character = true,
			-- Shows after entering insert mode on top of a trigger charcter.
			show_on_insert_on_trigger_character = true,
		},
		keyword = { range = "full" },
		list = {
			selection = {
				preselect = true,
				auto_insert = true,
			},
		},
		menu = {
			enabled = true,
			min_width = 150,
			draw = {
				-- Aligns the keyword you've typed to a component in the menu
				align_to = "label", -- or 'none' to disable, or 'cursor' to align to the cursor
				-- Gap between columns
				gap = 1,
				-- Use treesitter to highlight the label text for the given list of sources
				treesitter = {},
				-- treesitter = { 'lsp' }
				padding = { 1, 1 }, -- padding only on right side,
				-- Components to render, grouped by column
				columns = { { "source_id", "kind_icon", gap = 2 }, { "label", "label_description", gap = 1 } },

				components = {
					label = {
						width = { fill = true, max = 60 },
						text = function(ctx)
							return ctx.label .. ctx.label_detail
						end,
						highlight = function(ctx)
							-- label and label details
							local highlights = {
								{
									0,
									#ctx.label,
									group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
								},
							}
							if ctx.label_detail then
								table.insert(
									highlights,
									{ #ctx.label, #ctx.label + #ctx.label_detail, group = "BlinkCmpLabelDetail" }
								)
							end

							-- characters matched on the label by the fuzzy matcher
							for _, idx in ipairs(ctx.label_matched_indices) do
								table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
							end

							return highlights
						end,
					},

					label_description = {
						width = { max = 70 },
						text = function(ctx)
							return ctx.label_description
						end,
						highlight = "BlinkCmpLabelDescription",
					},
				},
			},
			border = "single",
			-- border = "double",
			-- border = nill,
		},
		documentation = { window = { border = "single" } },
	},
	signature = {
		enabled = true,
		window = {
			border = "single",
		},
	},
	cmdline = { completion = { menu = { auto_show = true } } },
	snippets = { preset = "luasnip" },

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
	keymap = { preset = "super-tab" },

	appearance = {
		-- Sets the fallback highlight groups to nvim-cmp's highlight groups
		-- Useful for when your theme doesn't support blink.cmp
		-- Will be removed in a future release
		use_nvim_cmp_as_default = true,
		-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",

		-- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
		kind_icons = {
			Copilot = "",
			Text = "󰉿",
			Method = "󰊕",
			Function = "󰊕",
			Constructor = "󰒓",

			Field = "󰜢",
			Variable = "󰆦",
			Property = "󰖷",

			Class = "󱡠",
			Interface = "󱡠",
			Struct = "󱡠",
			Module = "󰅩",

			Unit = "󰪚",
			Value = "󰦨",
			Enum = "󰦨",
			EnumMember = "󰦨",

			Keyword = "󰻾",
			Constant = "󰏿",

			Snippet = "󱄽",
			Color = "󰏘",
			File = "󰈔",
			Reference = "󰬲",
			Folder = "󰉋",
			Event = "󱐋",
			Operator = "󰪚",
			TypeParameter = "󰬛",
		},
	},

	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = { "lsp", "snippets", "buffer", "path" },
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
			cmdline = {
				-- ignores cmdline completions when executing shell commands
				enabled = function()
					return vim.fn.getcmdtype() ~= ":" or not vim.fn.getcmdline():match("^[%%0-9, '<>%-]*!")
				end,
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
