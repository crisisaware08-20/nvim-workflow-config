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

-- Used as "quickly try things"
function M.explore()
	-- local fruits = { "apple", "banana", "orange", "blueberry" }
	-- for key, value in pairs(fruits) do
	-- 	print(key, value)
	-- end
	--

  local gugu = 	M.find_student("Gugu")
		M.print_details(gugu)


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

local students = {
	{ name = "Gugu",  age = 2, grade = "A" },
	{ name = "Lia",   age = 5, grade = "B" },
	{ name = "Matei", age = 8, grade = "C" },
}

function M.print_details(children)
	print(children.name)
	print(children.age)
	print(children.grade)
end

function M.find_student(name)
	for _, student in ipairs(students) do
		if student.name == name then
			return student
		end
		return nil
	end
end


return M
