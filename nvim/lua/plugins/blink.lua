require('blink.cmp').setup({
	sources = {
		-- The lsp, path, snippets, luasnip, buffer, and omni sources are built-in
		default = { 'lsp', 'buffer', 'path', 'omni' }
	},
	completion = {
		menu = {
			draw = {
				columns = { { 'label', 'label_description', 'source_name', gap = 1 } }
			}
		}
	},
	cmdline = {
		keymap = { preset = 'cmdline' },
		enabled = false
	}
})

-- List of available components: source_id, source_name, kind, label_description, label, kind_icon, got table: 0x01011af4d8
