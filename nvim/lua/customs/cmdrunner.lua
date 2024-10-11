local harpoon = require("harpoon")
local utils = require("harpoon.utils")

local M = {}

-- functions inside

function M.find_usable_terminal()
	local pane_id, curr_pane_idx

	local pane_list, _, _ = utils.get_os_command_output({
		"tmux",
		"list-panes",
		"-F",
		"#{pane_index}:#{pane_active}:#{pane_current_command}",
	}, vim.loop.cwd())

	for _, line in pairs(pane_list) do
		local pane_info = utils.split_string(line, ":")
		local idx = pane_info[1]
		local active = pane_info[2]
		local cmd = pane_info[3]

		if cmd == "zsh" then
			pane_id = idx
		elseif active == "1" then
			curr_pane_idx = idx
		end
	end

	if not pane_id then
		pane_id = utils.get_os_command_output({
			"tmux",
			"split-window",
			"-P",
			"-l",
			"17",
			"-F",
			"#{pane_index}",
		}, vim.loop.cwd())[1]
	end

	return { pane_id = pane_id, curr_pane_idx = curr_pane_idx }
end

function M.run_harpoon_cmd(cmd, ...)
	local id_table = M.find_usable_terminal()
	local pane_id = id_table.pane_id
	local curr_pane_id = id_table.curr_pane_idx

	M.go_to_split_terminal(pane_id)
	M.send_command(pane_id, cmd, ...)
	M.go_to_split_terminal(curr_pane_id)
end

function M.send_command(idx, cmd_idx, ...)
	local cmd = harpoon.get_term_config().cmds[cmd_idx]
	local _, ret, stderr = utils.get_os_command_output({
		"tmux",
		"send-keys",
		"-t",
		idx,
		string.format(cmd, ...),
		"C-m",
	}, vim.loop.cwd())

	if ret ~= 0 then
		error("Failed to Send Commands to terminal." .. stderr[1])
	end
end

function M.go_to_split_terminal(idx)
	local _, ret, stderr = utils.get_os_command_output({
		"tmux",
		"select-pane",
		"-t",
		idx,
	}, vim.loop.cwd())

	if ret ~= 0 then
		error("Failed to go to terminal." .. stderr[1])
	end
end

return M
