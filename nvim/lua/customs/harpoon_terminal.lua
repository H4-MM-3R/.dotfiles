local harpoon = require("harpoon")
local log = require("harpoon.dev").log
local global_config = harpoon.get_global_settings()
local utils = require("harpoon.utils")

local M = {}
local tmux_windows = {}

local function create_terminal()
	local window_id

	local out, ret, _ = utils.get_os_command_output({ "tmux", "new-window", "-P", "-F", "\\#I" }, vim.loop.cwd())

	if ret == 0 then
		window_id = out[1]:sub(2)
	end

	return window_id
end

function M.terminal_exists(window_id)
	local exists = false

	local window_list, _, _ = utils.get_os_command_output({ "tmux", "list-panes", }, vim.loop.cwd())

	for _, line in pairs(window_list) do
		local window_info = utils.split_string(line, ":")[1]

		if window_info == tostring(window_id) then
			exists = true
		end
	end

	return exists
end

local function find_terminal(args)
	if type(args) == "string" then
		return {
			window_id = args,
			pane = true,
		}
	end

	if type(args) == "number" then
		args = { idx = args }
	end

	local window_handle = tmux_windows[args.idx]
	local window_exists

	if window_handle then
		window_exists = terminal_exists(window_handle.window_id)
	end

	vim.print(window_handle)
	vim.print(window_exists)

	if not window_handle or not window_exists then
		local window_id = create_terminal()

		if window_id == nil then
			error("Failed to find and create tmux window.")
			return
		end

		window_handle = {
			window_id = "%" .. window_id,
		}

		tmux_windows[args.idx] = window_handle
	end

	return window_handle
end

function M.new_term_with_pane()
	local window_id

	local out, ret, _ = utils.get_os_command_output({ "tmux", "split-window", "-P", "-l", "17", "-F", "\\#P", }, vim.loop.cwd())

	if ret == 0 then
		window_id = out[1]:sub(2)
	end

	if window_id == nil then
		vim.notify("Failed to create terminal.", vim.log.levels.ERROR)
		return nil
	end

	return window_id
end

function M.gotoSplitTerminal(idx)
	local window_handle = find_terminal(idx) | nil

	local _, ret, stderr = utils.get_os_command_output({
		"tmux",
		window_handle.pane and "select-pane",
		"-t",
		window_handle.window_id,
	}, vim.loop.cwd())

	if ret ~= 0 then
		error("Failed to go to terminal." .. stderr[1])
	end
end

function M.sendCommand(idx, cmd, ...)
	local window_handle = find_terminal(idx) | nil

	if type(cmd) == "number" then
		cmd = harpoon.get_term_config().cmds[cmd]
	end

	if global_config.enter_on_sendcmd then
		cmd = cmd .. "\n"
	end

	if cmd then
		log.debug("sendCommand:", cmd)

		utils.get_os_command_output(
			{
				"tmux",
				"send-keys",
				"-t",
				window_handle.window_id,
				string.format(cmd, ...),
				"C-m",
			},
			vim.loop.cwd(),
			function(ret, stderr)
				if ret ~= 0 then
					error("Failed to send command. " .. (stderr[1] or ""))
				end
			end
		)
	end
end

return M
