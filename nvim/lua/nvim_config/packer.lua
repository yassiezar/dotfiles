local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function()
    --- Package manager
    use("wbthomason/packer.nvim")

    --- Colour scheme stuff
    use("morhetz/gruvbox")
    use { "catppuccin/nvim",
      as = "catppuccin",
      run = ":CatppuccinCompile"
    }

    --- Linting configurations
    use 'mfussenegger/nvim-lint'

    -- ASync setup
    -- TODO: Move to under telescope
    use("nvim-lua/plenary.nvim")

    -- Devicons
    use("nvim-tree/nvim-web-devicons")
    use('onsails/lspkind.nvim')

    -- Telescope for file preview
    use("nvim-telescope/telescope.nvim")
    use {
      "nvim-telescope/telescope-frecency.nvim",
      requires = {"tami5/sqlite.lua"}
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {'nvim-telescope/telescope-dap.nvim' }

    -- Statusline
    use {
      'nvim-lualine/lualine.nvim',
      requires = {'nvim-tree/nvim-web-devicons', opt = true}
    }
    -- Tabline
    use {
      'romgrk/barbar.nvim',
      requires = {'nvim-tree/nvim-web-devicons'}
    }

    -- Code highlighting
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    -- NVim Tree
    use {
      'nvim-tree/nvim-tree.lua',
      requires = {'nvim-tree/nvim-web-devicons'}
    }

    -- Element highlighting
    use("yamatsum/nvim-cursorline")

    use {
      'VonHeikemen/lsp-zero.nvim',
      -- Code completion and LSP setup
      requires = {
        {
          'williamboman/mason.nvim',
          run = ":MasonUpdate"
        },
        {'williamboman/mason-lspconfig.nvim'},
        {'neovim/nvim-lspconfig'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-cmdline'},
        {'hrsh7th/cmp-nvim-lsp-signature-help'},
      }
    }

    -- Snippets
    use('L3MON4D3/LuaSnip')
    use('rafamadriz/friendly-snippets')
    use('saadparwaiz1/cmp_luasnip')

    -- Formatting
    use('mhartington/formatter.nvim')

    -- Version control integration
    use('ngemily/vim-vp4')

    -- Commenting support
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }

    -- Debugging
    use('mfussenegger/nvim-dap')
    use('nvim-neotest/nvim-nio')
    use{'rcarriga/nvim-dap-ui',
        requires = 'nvim-neotest/nvim-nio'
    }
    use('mfussenegger/nvim-dap-python')

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
end)
