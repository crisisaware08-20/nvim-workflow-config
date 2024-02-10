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

function M.explore()
	local fruits = {"apple", "banana", "orange", "blueberry"}
	for key, value in pairs(fruits) do
		print(key, value)
	end

end

-- Define a variable to store the original window height
local original_height

-- Define a function to resize the buffer vertically to the top
function M.ResizeBufferTop()
    -- Save the current window height
    original_height = vim.api.nvim_win_get_height(0)

    -- Resize the buffer to the top
    vim.cmd('resize +6000')  -- Increase height by 5 lines (adjust as needed)
end

-- Define a function to restore the original window size
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

return M
