local api = vim.api
local ts_utils = require "nvim-treesitter.ts_utils"
local parsers = require "nvim-treesitter.parsers"
local queries = require "nvim-treesitter.query"
local configs = require "nvim-treesitter.configs"

-- Store queries we'll use for navigation
local query_strings = {
	method_definition = [[
        (method_declaration) @method
    ]],
	class_definition = [[
        (class_declaration) @class
    ]],
	interface_definition = [[
        (interface_declaration) @interface
    ]]
}

-- Buffer state management
local state = setmetatable({}, {
	__index = function(tbl, key)
		tbl[key] = {
			queries = {},
			parser = nil
		}
		return tbl[key]
	end
})

-- Check if Java parser is available
local function ensure_parser(bufnr)
	if not parsers.has_parser('java') then
		vim.notify("Java parser not installed. Run :TSInstall java", vim.log.levels.ERROR)
		return false
	end
	return true
end

-- Helper function to get node at cursor
local function get_node_at_cursor()
	local row, col = unpack(api.nvim_win_get_cursor(0))
	row = row - 1 -- Convert to 0-based index
	return ts_utils.get_node_at_cursor()
end

-- Navigation functions
function goto_next_method()
	local bufnr = api.nvim_get_current_buf()
	if not state[bufnr].parser then return end

	local current_node = get_node_at_cursor()
	if not current_node then return end

	local matches = {}
	for _, match in state[bufnr].queries.method:iter_matches(state[bufnr].parser:parse()[1]:root()) do
		table.insert(matches, match[1])
	end

	local current_row = current_node:start()
	for _, node in ipairs(matches) do
		if node:start() > current_row then
			ts_utils.goto_node(node)
			return
		end
	end

	vim.notify("No more methods found", vim.log.levels.INFO)
end

function goto_prev_method()
	local bufnr = api.nvim_get_current_buf()
	if not state[bufnr].parser then return end

	local current_node = get_node_at_cursor()
	if not current_node then return end

	local matches = {}
	for _, match in state[bufnr].queries.method:iter_matches(state[bufnr].parser:parse()[1]:root()) do
		table.insert(matches, match[1])
	end

	local current_row = current_node:start()
	for i = #matches, 1, -1 do
		if matches[i]:start() < current_row then
			ts_utils.goto_node(matches[i])
			return
		end
	end

	vim.notify("No previous methods found", vim.log.levels.INFO)
end

function goto_parent_type()
	local current_node = get_node_at_cursor()
	while current_node do
		if current_node:type() == 'class_declaration' or
				current_node:type() == 'interface_declaration' then
			ts_utils.goto_node(current_node)
			return
		end
		current_node = current_node:parent()
	end
	vim.notify("No parent class/interface found", vim.log.levels.INFO)
end

-- Register the module
require("nvim-treesitter").define_modules {
	java_jumps = {
		attach = function(bufnr, lang)
			-- local config = configs.get_module "java_jumps"

			-- Only attach to Java buffers
			if lang ~= "java" then return end

			-- Ensure parser is available
			if not ensure_parser(bufnr) then return end

			-- Initialize buffer state
			state[bufnr].parser = parsers.get_parser(bufnr, lang)
			state[bufnr].queries.method = vim.treesitter.query.parse(lang, query_strings.method_definition)


			-- Set up keymaps
			local opts = { buffer = bufnr, silent = true }
			vim.keymap.set('n', 'gj', goto_next_method, vim.tbl_extend('force', opts, { desc = "Go to next method" }))
			vim.keymap.set('n', 'gk', goto_prev_method, vim.tbl_extend('force', opts, { desc = "Go to previous method" }))
			vim.keymap.set('n', 'gp', goto_parent_type, vim.tbl_extend('force', opts, { desc = "Go to parent type" }))
		end,
		detach = function(bufnr)
			if state[bufnr] then
				state[bufnr] = nil
			end

			-- Remove keymaps
			pcall(vim.keymap.del, 'n', 'gj', { buffer = bufnr })
			pcall(vim.keymap.del, 'n', 'gk', { buffer = bufnr })
			pcall(vim.keymap.del, 'n', 'gp', { buffer = bufnr })
		end,
		-- module_path = "nvim-treesitter.java_jumps",
		enable = true, -- disabled by default
		disable = {}, -- no languages disabled by default
		is_supported = function(lang)
			return lang == "java"
		end,
	}
}
