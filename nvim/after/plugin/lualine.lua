local status, lualine = pcall(require, "lualine")
if (not status) then return end

local custom_solarized = require'lualine.themes.solarized_dark'

local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "Recording @" .. recording_register
    end
end


vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function ()
        lualine.refresh({
            place = { "statusline" },
        })
    end,
})


vim.api.nvim_create_autocmd("RecordingLeave", {
    callback = function()
        local timer = vim.loop.new_timer()
        timer:start(
        50,
        0,
        vim.schedule_wrap(function()
            lualine.refresh({
                place = { "statusline" },
            })
        end)
        )
    end,
})


custom_solarized.normal.a.bg = '#073642'
custom_solarized.normal.a.fg = '#eee8d5'
custom_solarized.normal.b.bg = '#073642'
custom_solarized.normal.b.fg = '#eee8d5'
custom_solarized.normal.c.bg = '#002b36'
custom_solarized.insert.a.bg = '#657b83'
custom_solarized.visual.a.bg = '#b58900'
custom_solarized.inactive.a.bg = '#002b36'
custom_solarized.inactive.a.fg = '#eee8d5'

lualine.setup {
  options = {
    icons_enabled = true,
    theme = custom_solarized,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
      lualine_a = {
          { 'mode',
          separator = {right = '' }
      }
  },
  lualine_b = {
      {
          "macro-recording",
          fmt = show_macro_recording,
      }, { "branch" }
  },
  lualine_c = { {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 0 -- 0 = just filename, 1 = relative path, 2 = absolute path
  } },
  lualine_x = {
      { 'diagnostics',
      sources = { "nvim_diagnostic" },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
  },
},
lualine_y = {
    {
        'filetype',
        colored = false,
        icon_only = false,
        icon = { align = 'right' },
    },
},
lualine_z = {
    'location',
},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {
    },
    lualine_c = { {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
    } },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },

  tabline = {},
  extensions = { 'fugitive', 'quickfix' , 'trouble'}
}
