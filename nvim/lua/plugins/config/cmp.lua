local cmp = require('cmp')
local luasnip = require('luasnip')
-- Custom cmp mapping config
local cmp_custom_mappings =
{
	['<Tab>'] = cmp.mapping(function(fallback)
		if luasnip.jumpable(1) then
			luasnip.jump(1)
		else
			fallback()
		end
	end, { 'i', 's' }),
	['<S-Tab>'] = cmp.mapping(function(fallback)
		if luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, { 'i', 's' }),
	['<CR>'] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		else
			fallback()
		end
	end, { 'i', 's' }),
}


cmp.setup({
	completion = {
		completeopt = 'menu,menuone,preview'
	},

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- Use LuaSnip to expand LSP snippets
		end,
	},

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	-- mapping = cmp.mapping.preset.insert({}),
	mapping = cmp.mapping.preset.insert(cmp_custom_mappings),

	formatting = {
		expandable_indicator = true,
		fields = { 'menu', 'kind', 'abbr' },
		format = function(_, vim_item)
			if vim_item.kind == 'Method' then
				vim_item.abbr = "🔧 " .. vim_item.abbr
			end
			return vim_item
		end,
	},

	-- formatting
	-- confirmation
	-- matching
	-- view

	sources = cmp.config.sources(
		{
			-- Primary source
			{ name = 'nvim_lsp' },
			-- { name = 'luasnip' },
		},
		-- Fallback sources
		{
			{ name = 'buffer' },
		}
	),
})

cmp.setup.filetype('java',
	{
		sources = cmp.config.sources(
			{
				-- Primary source
				{ name = 'nvim_lsp' },
				-- { name = 'luasnip' },
			},
			-- Fallback sources
			{
				-- { name = 'buffer' },
			}
		)
	}
)


-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' },
	}, {
		{ name = 'cmdline' }
	})
})
