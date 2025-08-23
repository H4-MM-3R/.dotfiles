return {
	cmd = "rg",
	prompt = "   ",
	formatters = {
		selected = {
			show_always = true,
			unselected = false,
		},
	},
	format = function(item, picker)
		---@type snacks.picker.Highlight[]
		local uv = vim.uv or vim.loop
		local ret = {}
		if not item.file then
			return ret
		end
		local path = Snacks.picker.util.path(item) or item.file
		path = Snacks.picker.util.truncpath(path, picker.opts.formatters.file.truncate or 40, { cwd = picker:cwd() })
		local name, cat = path, "file"
		if item.buf and vim.api.nvim_buf_is_loaded(item.buf) then
			name = vim.bo[item.buf].filetype
			cat = "filetype"
		elseif item.dir then
			cat = "directory"
		end

		if picker.opts.icons.files.enabled ~= false then
			local icon, hl = Snacks.util.icon(name, cat, {
				fallback = picker.opts.icons.files,
			})
			if item.dir and item.open then
				icon = picker.opts.icons.files.dir_open
			end
			icon = Snacks.picker.util.align(icon, picker.opts.formatters.file.icon_width or 2)
			ret[#ret + 1] = { icon, hl, virtual = true }
		end

		local base_hl = item.dir and "SnacksPickerDirectory" or "SnacksPickerFile"
		local function is(prop)
			local it = item
			while it do
				if it[prop] then
					return true
				end
				it = it.parent
			end
		end
		-- vim.print(vim.inspect(picker.list.selected_map))

		if is("ignored") then
			base_hl = "SnacksPickerPathIgnored"
		elseif is("hidden") then
			base_hl = "SnacksPickerPathHidden"
		elseif item.filename_hl then
			base_hl = item.filename_hl
		end
		local dir_hl = "SnacksPickerDir"

		if picker.list.selected_map[item._select_key] then
			base_hl = picker.opts.formatters.file.selected_hl or "SnacksPickerSelected"
		end

		if picker.opts.formatters.file.filename_only then
			path = vim.fn.fnamemodify(item.file, ":t")
			ret[#ret + 1] = { path, base_hl, field = "file" }
		else
			local dir, base = path:match("^(.*)/(.+)$")
			if base and dir then
				if picker.opts.formatters.file.filename_first then
					ret[#ret + 1] = { base, base_hl, field = "file" }
					ret[#ret + 1] = { " " }
					ret[#ret + 1] = { dir, dir_hl, field = "file" }
				else
					ret[#ret + 1] = { dir .. "/", dir_hl, field = "file" }
					ret[#ret + 1] = { base, base_hl, field = "file" }
				end
			else
				ret[#ret + 1] = { path, base_hl, field = "file" }
			end
		end
		if item.pos and item.pos[1] > 0 then
			ret[#ret + 1] = { ":", "SnacksPickerDelim" }
			ret[#ret + 1] = { tostring(item.pos[1]), "SnacksPickerRow" }
			if item.pos[2] > 0 then
				ret[#ret + 1] = { ":", "SnacksPickerDelim" }
				ret[#ret + 1] = { tostring(item.pos[2]), "SnacksPickerCol" }
			end
		end
		ret[#ret + 1] = { " " }
		if item.type == "link" then
			---@diagnostic disable-next-line: undefined-field
			local real = uv.fs_realpath(item.file)
			local broken = not real
			---@diagnostic disable-next-line: undefined-field
			real = real or uv.fs_readlink(item.file)
			if real then
				ret[#ret + 1] = { "-> ", "SnacksPickerDelim" }
				ret[#ret + 1] = {
					Snacks.picker.util.truncpath(real, 20),
					broken and "SnacksPickerLinkBroken" or "SnacksPickerLink",
				}
				ret[#ret + 1] = { " " }
			end
		end
		return ret
	end,
}
