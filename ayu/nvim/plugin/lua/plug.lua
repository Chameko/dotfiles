vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can mangage itself
    use 'wbthomason/packer.nvim'

    -- Indent guide
    use "lukas-reineke/indent-blankline.nvim"

    -- Which key so I know what I'm doing <_<
    use 'folke/which-key.nvim'

    -- Telescope
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Ayu theme
    use {'Shatur/neovim-ayu', as = 'ayu' }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- Auto pairs
    use "windwp/nvim-autopairs"
    
    -- Color highlighter
    use "norcalli/nvim-colorizer.lua"

    -- Icons
    use "kyazdani42/nvim-web-devicons"

    -- File tree
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {
            'kyazdani42/nvim-web-devicons'
        },
    }

    -- LSP configs
    use "neovim/nvim-lspconfig"

    -- Manage external LSP
    use "williamboman/mason.nvim"

    -- Bridge between lsp config and mason
    use {
        "williamboman/mason-lspconfig.nvim",
        requires = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig"
        }
    }

    -- Git signs
    use "lewis6991/gitsigns.nvim"

    -- Completion framework
    use "hrsh7th/nvim-cmp"
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'saadparwaiz1/cmp_luasnip'

    -- Rust
    use 'simrat39/rust-tools.nvim'

    -- Toggle terminal
    use {"akinsho/toggleterm.nvim", tag = 'v2.*', config = function()
      require("toggleterm").setup()
    end}

    -- Snippets
    use "rafamadriz/friendly-snippets"
    use "L3MON4D3/LuaSnip"

    -- Pretty lsp icons
    use "onsails/lspkind.nvim"

    -- Buffer line
    use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
    
end)
