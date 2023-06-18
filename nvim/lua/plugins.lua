local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  -- dependencies
  'nvim-tree/nvim-web-devicons',
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',

  { 'folke/which-key.nvim', opts = {} }, -- pending keys
  'mg979/vim-visual-multi', -- multiline cursors

  { 'norcalli/nvim-colorizer.lua', opts = {} },

  -- colorschemes
  {"rebelot/kanagawa.nvim", name = "kanagawa", opts = {}},
  {"folke/zen-mode.nvim", opts = {window = { options = {signcolumn = "no", number = false, relativenumber = false, cursorcolumn = false}}}},

  'nvim-lualine/lualine.nvim', -- statusline

  { -- syntax highlight
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },

  { -- indentation guides
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  { 'numToStr/Comment.nvim', opts = {} }, -- comment
  { 'j-hui/fidget.nvim', opts = {} }, -- buttom right spinner

  { -- LSP
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional

      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    }
  },
  { -- document generator
    'kkoomen/vim-doge',
    build = ':call doge#install()'
  },
})
