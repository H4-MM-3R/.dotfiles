local harpoon = require("harpoon")
local utils = require("harpoon.utils")

local M = {}

function M.find_terminal_window()
    local window_id

    local window_list, _, _ = utils.get_os_command_output({
        "tmux",
		"list-windows",
		"-F",
		"#{window_index}:#{window_name}",
    }, vim.loop.cwd())

    for _, line in pairs(window_list) do
        local window_info = utils.split_string(line, ":")
        local idx = window_info[1]
        local name = window_info[2]

        if name == "terminal" then
            window_id = idx
        end
    end

    if not window_id then
		window_id = utils.get_os_command_output({
			"tmux",
			"new-window",
			"-d",
			"-n",
			"terminal",
            "-P",
            "-F",
            "#{window_index}",
		}, vim.loop.cwd())[1]
    end
    return { window_id = window_id }
end

function M.run_harpoon_cmd(cmd_idx, ...)
    local id_table = M.find_terminal_window()
    local window_id = id_table.window_id
    local cmd = harpoon.get_term_config().cmds[cmd_idx]

    M.go_to_window_terminal(window_id)
    if cmd ~= nil then
        M.send_command(window_id, cmd_idx, ...)
    end
end

function M.send_command(idx, cmd_idx, ...)
    local cmd = harpoon.get_term_config().cmds[cmd_idx]
    local _ = utils.get_os_command_output({
        "tmux",
        "send-keys",
        "-t",
        idx,
        string.format(cmd, ...),
        "C-m",
    }, vim.loop.cwd())
end

function M.go_to_window_terminal(idx)
    local _, ret, stderr = utils.get_os_command_output({
        "tmux",
        "select-window",
        "-t",
        idx,
    }, vim.loop.cwd())

    if ret ~= 0 then
        error("Failed to go to terminal." .. stderr[1])
    end
end

return M
