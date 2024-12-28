local M = {}


function M.print_path_option()
	print("NVim paths:")
	for _, path_entry in ipairs(vim.opt.path:get()) do
		print(path_entry)
	end
end


-- Change directory to current buffer, not quite used --> may be removed
function M.change_nvim_directory_to(path)
	vim.fn.chdir(path)
	print("Directory changed to" .. path .. " ")
end

function M.show_runtime_path()
	local runtimepath = vim.opt.runtimepath
	print("runtimepath !!!")

	for _, path in ipairs(runtimepath) do
		print(path)
	end
end


-- Functions for maximizing and restoring the current buffer's size
local original_height
function M.ResizeBufferTop()
	original_height = vim.api.nvim_win_get_height(0)
	vim.cmd('resize +6000')
end

function M.RestoreOriginalSize()
	if original_height ~= nil then
		local current_height = vim.api.nvim_win_get_height(0)
		local diff = original_height - current_height

		if diff > 0 then
			vim.cmd('resize +' .. diff)
		elseif diff < 0 then
			vim.cmd('resize ' .. diff)
		end

		original_height = nil
	end
end

-- Set key maping for the provided keymap_groups
function M.set_keymaps(bufnr, keymap_groups)
	for _, group in ipairs(keymap_groups) do
		-- Default to normal mode if no mode is specified
		local modes = group.mode or { "n" }
		for _, map in ipairs(group) do
			-- Skip the "mode" field itself
			if type(map) == "table" and map[1] then
				local lhs = map[1]
				local rhs = map[2]
				local opts = { noremap = true, silent = true, desc = map.desc }
				for _, mode in ipairs(modes) do
					vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { buffer = bufnr }))
				end
			end
		end
	end
end

return M
