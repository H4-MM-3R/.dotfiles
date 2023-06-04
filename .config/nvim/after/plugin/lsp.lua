---@diagnostic disable: undefined-global
local saga = require("lspsaga")
local lspkind = require("lspkind")
local null_ls = require("null-ls")
local protocol = require("vim.lsp.protocol")
local capabilities = vim.lsp.protocol.make_client_capabilities()
local get_servers = require("mason-lspconfig").get_installed_servers
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local formatter = null_ls.builtins.formatting
local cmp = require("cmp")

--##################################################################
--#                       LSP Configuration                        #
--##################################################################

require("mason").setup()
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
require('lspconfig').emmet_ls.setup({
    capabilities = capabilities,
})
require('lspconfig').sqlls.setup({
    capabilities = capabilities,
})
require('lspconfig').eslint.setup({
    capabilities = capabilities,
})
require('lspconfig').stylelint_lsp.setup({
    capabilities = capabilities,
})
require('lspconfig').bashls.setup({
    capabilities = capabilities,
})
require('lspconfig').svelte.setup({
    capabilities = capabilities,
})
require('lspconfig').tailwindcss.setup({
    capabilities = capabilities,
})
require('lspconfig').pyright.setup({
    capabilities = capabilities,
})
require('lspconfig').cssmodules_ls.setup({
    capabilities = capabilities,
})
require('lspconfig').vuels.setup({
    capabilities = capabilities,
})
require('lspconfig').yamlls.setup({
    capabilities = capabilities,
})
require('lspconfig').jsonls.setup({
    capabilities = capabilities,
})
require('lspconfig').unocss.setup({
    capabilities = capabilities,
})
require('lspconfig').rust_analyzer.setup({
    capabilities = capabilities,
})
require('lspconfig').kotlin_language_server.setup({
    capabilities = capabilities,
})
require('lspconfig').clangd.setup({
    capabilities = capabilities,
})
require('lspconfig').tsserver.setup({
    capabilities = capabilities,
})
require('lspconfig').ruby_ls.setup({
    capabilities = capabilities,
})

protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

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
    formatter.clang_format,
    formatter.prettier,
    formatter.black,
    formatter.standardrb,
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
      ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      ["<Tab>"] = cmp.mapping.select_next_item(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'text_symbol',
      maxwidth = 50,
      ellipsis_char = '...',
    })
  }
})

--##################################################################
--#                            LSP-UI                              #
--##################################################################


saga.setup({
  ui = {
    winblend = 10,
    border = 'rounded',
    colors = {
      normal_bg = '#002b36'
    }
  },
  symbol_in_winbar = {
    enable = false
  }
})


