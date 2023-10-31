local saga = require("lspsaga")
local lspkind = require("lspkind")
local null_ls = require("null-ls")
local capabilities = vim.lsp.protocol.make_client_capabilities()
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local formatter = null_ls.builtins.formatting
local cmp = require("cmp")
local luasnip = require("luasnip")
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

--##################################################################
--#                       LSP Configuration                        #
--##################################################################
require("mason").setup({})
require("mason-lspconfig").setup({})
capabilities.offsetEncoding = 'utf-8'

require('lspconfig').lua_ls.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
      }
    }
})
require('lspconfig').jdtls.setup({
    capabilities = capabilities,

})
require('lspconfig').emmet_ls.setup({
    capabilities = capabilities,
})
require('lspconfig').sqlls.setup({
    capabilities = capabilities,
})
require('lspconfig').bashls.setup({
    capabilities = capabilities,
})
require('lspconfig').pyright.setup({
    capabilities = capabilities,
})
require('lspconfig').yamlls.setup({
    capabilities = capabilities,
})
require('lspconfig').clangd.setup({
    capabilities = capabilities,
})
require('lspconfig').tsserver.setup({
    capabilities = capabilities,
})
require('lspconfig').lemminx.setup({
    capabilities = capabilities,
})


--##################################################################
--#                 Formatter Configuration                        #
--##################################################################


require("mason-null-ls").setup({
  automatic_setup = true,
})
null_ls.setup({
  on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
  sources = {
    formatter.clang_format.with({
        filetypes = {"c", "cpp", "cs"}
    }),
    formatter.google_java_format,
    formatter.prettier,
    formatter.black,
    formatter.xmlformat,
  },
})

--##################################################################
--#                        Auto Completion                         #
--##################################################################


require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
  },
  mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
      -- they way you will only jump inside the snippet region
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format({
      wirth_text = false,
      maxwidth = 50,
    })
  }
})

--##################################################################
--#                            LSP-UI                              #
--##################################################################



lspkind.init({
    mode = 'symbol_text',
    preset = 'codicons',
    symbol_map = {
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰜢",
      Variable = "󰀫",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "󰑭",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "󰙅",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "",
    }
})


saga.setup({
  ui = {
    winblend = 10,
    border = 'rounded',
    colors = {
      normal_bg = '#002b36'
    }
  },
  symbol_in_winbar = {
    enable = true,
    separator = ' / ',
    folder_level = 0,
  }
})
