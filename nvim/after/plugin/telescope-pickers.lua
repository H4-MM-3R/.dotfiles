local actions = require("telescope.actions")
require("telescope").setup {
  defaults = {
      mappings = {
          n = {
              ["<C-q>"] = actions.smart_send_to_qflist,
              ["<C-l>"] = actions.smart_send_to_loclist,
          },
          i = {
              ["<C-q>"] = actions.smart_send_to_qflist,
              ["<C-l>"] = actions.smart_send_to_loclist,
          },
      },
      prompt_prefix = "   ",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
     },
  },
  extensions = {
    file_browser = {
      grouped = true,
      hidden = { file_browser = true, folder_browser = true },
      hijack_netrw = true,
      theme = false,
            hide_parent_dir = true,
    },
  },
}

require("telescope").load_extension "file_browser"
require("telescope").load_extension("harpoon")












