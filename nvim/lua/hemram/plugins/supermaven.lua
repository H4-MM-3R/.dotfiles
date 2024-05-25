return {
  {
      "supermaven-inc/supermaven-nvim",
      config = function()
        require("supermaven-nvim").setup({
            keymaps = {
                accept_suggestion = "<C-\\>",
                clear_suggestion = "<M-x>",
                accept_word = "<M-[>",
            },
        })
      end,
  }
}

