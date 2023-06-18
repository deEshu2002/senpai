local lsp = require("lsp-zero")
lsp.preset("recommended")

require("mason").setup()
mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
  ensure_installed = {
  'pyright', --python
  'yamlls', --yaml
  'bashls', -- bash
  'cssls', -- css
  'eslint', -- js
  'html', -- html
  'tsserver', -- typescript
  'marksman', -- markdown
  'rust_analyzer', -- rust
  'lua_ls',
  'gopls', -- go
  -- 'clangd', -- c, c++
  -- 'jdtls', -- java
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

end)

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()
lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

require'lspconfig'.yamlls.setup{
    on_attach=on_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = {
        yaml = {
            schemas = {
                ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"]= "conf/**/*catalog*",
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
            }
        }
    }
}

require('Comment').setup({
  toggler = {
        line = 'gcc',
        block = 'gbc',
    },
    opleader = {
        line = 'gc',
        block = 'gb',
    },
    extra = {
        above = 'gcO',
        below = 'gco',
        eol = 'gcA',
    },
})