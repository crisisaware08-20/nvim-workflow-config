-- mymodule.lua

local M = {}

function M.say_hello()
	print("Hello from the module!")
end

function M.add_numbers(a, b)
	return a + b
end

function M.print_path_option()
	print("NVim paths:")
	for _, path_entry in ipairs(vim.opt.path:get()) do
		print(path_entry)
	end
end

function M.change_nvim_directory_to(path)
	vim.fn.chdir(path)
	print("Directory changed to" .. path .. " ")
end

return M
