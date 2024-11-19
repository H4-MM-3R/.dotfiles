local M = {}
local scandir = require("plenary.scandir")
local path_utils = require("dotnet.utils.path-utils")

M.bootstrap_new_csharp_file = function(opts)
	opts = opts or {}
	local names = M.csharp_namespace_init(opts.path)
	local buffer = vim.api.nvim_get_current_buf()
	local line_count = vim.api.nvim_buf_line_count(buffer)

	local line_end = line_count
	local line_start = line_count - 1

	if opts.append == false then
		line_start = 0
	end

	if not names or not names.namespace then
		return
	end

	local lines = {
		"namespace " .. names.namespace .. ";",
		"",
		"public class " .. names.file_name,
		"{", -- Cursor will be here after the lines are set
		"}",
	}
	vim.api.nvim_buf_set_lines(buffer, line_start, line_end, false, lines)
	local cursor_line = line_start + 3
	local cursor_col = 4
	vim.api.nvim_win_set_cursor(0, { cursor_line + 1, cursor_col })
end

M.csharp_namespace_init = function(pathopts)
	local path = pathopts or string.gsub(vim.fn.expand("%:p"), "\\", "/")
	local directory = string.match(path, "(.+/)[^/\\]+%..+$")
	local file_name = string.match(path, "[^/\\]+%..+$")
	local file_base_name = string.match(path_utils.get_last_path_part(file_name), "[^%.]+")

	local parents = {}
	for dir in string.gmatch(directory, "[^/\\]+") do
		table.insert(parents, dir .. "/")
	end
	table.insert(parents, "")


	local result = {}
	local curr_directory = directory
	directory = string.gsub(directory, "-", "_")
	for i = #parents, 1, -1 do
		local directory_to_remove = parents[i]
		curr_directory = string.gsub(curr_directory, directory_to_remove, "")
		local foundFiles = scandir.scan_dir(curr_directory, { depth = 1 })
		for _, file in pairs(foundFiles) do
			if result.project == nil and string.match(file, "%.[fc]sproj") then
				curr_directory = string.gsub(curr_directory, "-", "_")
				local prev_file = string.gsub(parents[i - 1], "-", "_")
				curr_directory = string.gsub(curr_directory, prev_file, "")
				curr_directory = string.gsub(directory, curr_directory, "")
				curr_directory = string.gsub(curr_directory, "/", ".")
				curr_directory = string.gsub(curr_directory, "%.$", "")
				result = { namespace = curr_directory, file_name = file_base_name }
			end
		end
	end

	return result
end

return M
