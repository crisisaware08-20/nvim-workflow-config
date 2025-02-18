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
