vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself 38 plugins
  use 'wbthomason/packer.nvim'

  -- Navigation 
  use { "nvim-telescope/telescope.nvim"}
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use { "nvim-telescope/telescope-live-grep-args.nvim" }
  use { "nvim-lua/plenary.nvim"}
  use { "ThePrimeagen/harpoon" }

  -- User-Interface
   use { 'svrana/neosolarized.nvim' }
  use { 'craftzdog/solarized-osaka.nvim'}
  use { 'tjdevries/colorbuddy.nvim' }
  use { 'norcalli/nvim-colorizer.lua' }
  use { 'nvim-lualine/lualine.nvim' }
  use {'nvim-tree/nvim-web-devicons'}
  use {'folke/which-key.nvim'}
  use {'anuvyklack/pretty-fold.nvim'}
  use { 'anuvyklack/fold-preview.nvim',
    requires = 'anuvyklack/keymap-amend.nvim',
  }
  use { 'folke/noice.nvim',
    requires = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify'
    }
  }
  use { 'folke/todo-comments.nvim' }

  -- Treesitter 
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'nvim-treesitter/playground' }
  use ({ 'nvim-treesitter/nvim-treesitter-textobjects', after = "nvim-treesitter", requires = "nvim-treesitter/nvim-treesitter" })

  -- Git Support 
  use { 'tpope/vim-fugitive' }

  -- LSP Support 
  use { 'neovim/nvim-lspconfig' }
  use { 'williamboman/mason.nvim' }
  use {'williamboman/mason-lspconfig.nvim'}

  -- Java LSP
  use 'mfussenegger/nvim-jdtls'

  -- Autocompletion
  use {'hrsh7th/nvim-cmp'}
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'L3MON4D3/LuaSnip'}
  use {'rafamadriz/friendly-snippets'}
  use {'hrsh7th/cmp-buffer'}
  use {'hrsh7th/cmp-path'}
  use {'saadparwaiz1/cmp_luasnip'}
  use {'onsails/lspkind.nvim'}
  use {'nvimdev/lspsaga.nvim'}
  use {'jay-babu/mason-null-ls.nvim'}
  use {'jose-elias-alvarez/null-ls.nvim'}

  -- Auto-Commands
  use {'windwp/nvim-autopairs'}
  use {'windwp/nvim-ts-autotag'}
  use {'numToStr/Comment.nvim'}

  -- Zen Mode
  use {'folke/zen-mode.nvim'}
  use {'folke/twilight.nvim'}

  -- Other Utility
  use {'ThePrimeagen/vim-be-good'}
  use {'Eandrju/cellular-automaton.nvim'}
  use {'alec-gibson/nvim-tetris'}
  use {'tpope/vim-surround'}
  use {'folke/trouble.nvim'}

end)
