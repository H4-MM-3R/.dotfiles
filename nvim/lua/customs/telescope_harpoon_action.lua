local utility = require("telescope.actions.utils")

M = {}

local select = function(selection)
	local file = selection[1]

	if selection.path then
		file = selection.path
	end

	pcall(require("harpoon.mark").add_file, file)
end

M.mark_file = function(tb)
	if #require("telescope.actions.state").get_current_picker(tb):get_multi_selection() > 0 then
		utility.map_selections(tb, select)
	else
		utility.map_entries(tb, select)
	end

	require("telescope.actions").drop_all(tb)
	pcall(require("harpoon.ui").toggle_quick_menu)
end

return M
