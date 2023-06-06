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
    use('bi0ha2ard/telescope-ros.nvim') -- needs colcon (ROS2)
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

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

    -- Code completion setup
    use('neovim/nvim-lspconfig')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-cmdline')
    use('hrsh7th/nvim-cmp')

    -- Snippets
    use('L3MON4D3/LuaSnip')
    use('rafamadriz/friendly-snippets')
    use('saadparwaiz1/cmp_luasnip')

    -- Annotation (docstrings)
    use{
      'danymat/neogen',
      config = function()
        require('neogen').setup { 
          snippet_engine = 'luasnip'
        }
      end,
      requires = 'nvim-treesitter/nvim-treesitter',
    }

    -- Formatting
    use('mhartington/formatter.nvim')

    -- Rust
    use 'simrat39/rust-tools.nvim'
end)
