require("zen-mode").setup {
    window = {
        backdrop = 1,
        height = 0.9,
        options = {
          number = false,
          relativenumber = false,
          signcolumn = "no",
          list = false,
          cursorline = false,
        },
    },
}
require("twilight").setup {
    context = -1,
    treesitter = true,
}
