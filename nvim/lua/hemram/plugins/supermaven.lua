return {
  {
      "supermaven-inc/supermaven-nvim",
      commit = "40bde487fe31723cdd180843b182f70c6a991226",
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
