local status, lualine = pcall(require, "lualine")
if (not status) then return end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'solarized_dark',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = { 
	    { 'mode',
	    color = function(insert)
               return { fg = "eee8d5", bg = '#b58900' or '#839496' }
            end,
	     separator = {right = '' }
    	    }
    },
    lualine_b = {

    },
    lualine_c = { {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 0 -- 0 = just filename, 1 = relative path, 2 = absolute path
    } },
    lualine_x = {
      { 'diagnostics', 
      	sources = { "nvim_diagnostic" }, 
	symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
      	'encoding',
      	'fileformat',
    },
    lualine_y = { 
	    {
		    'filetype',
		    colored = false,
		    icon_only = false,
		    icon = { align = 'right' },
	    },
	    {
		'location',
	    },
    },
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {
	    {
		'buffers',
		filetype_names = {
			TelescopePrompt = 'Telescope',
			dashboard = 'Dashboard',
			packer = 'Packer',
			fzf = 'FZF',
			alpha = 'Alpha',
		},
	    }, 
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
  extensions = { 'fugitive' }
}
