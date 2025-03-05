local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local make_entry = require "telescope.make_entry"
local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"
local conf = require("telescope.config").values
local utils = require("telescope.utils")

local M = {}
M.current_buffer_fuzzy_find = function(opts)
  -- All actions are on the current buffer
  local filename = vim.api.nvim_buf_get_name(opts.bufnr)
  local filetype = vim.api.nvim_buf_get_option(opts.bufnr, "filetype")

  local lines = vim.api.nvim_buf_get_lines(opts.bufnr, 0, -1, false)
  local lines_with_numbers = {}

  for lnum, line in ipairs(lines) do
    table.insert(lines_with_numbers, {
      lnum = lnum,
      bufnr = opts.bufnr,
      filename = filename,
      text = line,
    })
  end

  opts.results_ts_highlight = vim.F.if_nil(opts.results_ts_highlight, true)
  local lang = vim.treesitter.language.get_lang(filetype) or filetype
  if opts.results_ts_highlight and lang and utils.has_ts_parser(lang) then
    local parser = vim.treesitter.get_parser(opts.bufnr, lang)
    local query = vim.treesitter.query.get(lang, "highlights")
    local root = parser:parse()[1]:root()

    local line_highlights = setmetatable({}, {
      __index = function(t, k)
        local obj = {}
        rawset(t, k, obj)
        return obj
      end,
    })

    for id, node in query:iter_captures(root, opts.bufnr, 0, -1) do
      local hl = "@" .. query.captures[id]
      if hl and type(hl) ~= "number" then
        local row1, col1, row2, col2 = node:range()

        if row1 == row2 then
          local row = row1 + 1

          for index = col1, col2 do
            line_highlights[row][index] = hl
          end
        else
          local row = row1 + 1
          for index = col1, #lines[row] do
            line_highlights[row][index] = hl
          end

          while row < row2 + 1 do
            row = row + 1

            for index = 0, #(lines[row] or {}) do
              line_highlights[row][index] = hl
            end
          end
        end
      end
    end

    opts.line_highlights = line_highlights
  end

  pickers
    .new(opts, {
      prompt_title = "Current Buffer Fuzzy",
      finder = finders.new_table {
        results = lines_with_numbers,
        entry_maker = opts.entry_maker or make_entry.gen_from_buffer_lines(opts),
      },
      sorter = conf.generic_sorter(opts),
      previewer = conf.grep_previewer(opts),
      attach_mappings = function()
        actions.select_default:replace(function(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if not selection then
            utils.__warn_no_selection "builtin.current_buffer_fuzzy_find"
            return
          end
          local current_picker = action_state.get_current_picker(prompt_bufnr)
          local searched_for = require("telescope.actions.state").get_current_line()

          ---@type number[] | {start:number, end:number?, highlight:string?}[]
          local highlights = current_picker.sorter:highlighter(searched_for, selection.ordinal) or {}
          highlights = vim.tbl_map(function(hl)
            if type(hl) == "table" and hl.start then
              return hl.start
            elseif type(hl) == "number" then
              return hl
            end
            error "Invalid higlighter fn"
          end, highlights)

          local first_col = 0
          if #highlights > 0 then
            first_col = math.min(unpack(highlights)) - 1
          end

          actions.close(prompt_bufnr)
          vim.schedule(function()
            vim.cmd "normal! m'"
            vim.api.nvim_win_set_cursor(0, { selection.lnum, first_col })
          end)
        end)

        return true
      end,
    })
    :find()
end

return M
