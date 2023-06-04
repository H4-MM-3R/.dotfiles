local fb_actions = require "telescope._extensions.file_browser.actions"
local actions = require("telescope.actions")
require("telescope").setup {
  extensions = {
    file_browser = {
      grouped = true,
      hidden = { file_browser = true, folder_browser = true },
      hijack_netrw = true,
      theme = "dropdown",
      hide_parent_dir = true,
    },
  },
}

require("telescope").load_extension "file_browser"












