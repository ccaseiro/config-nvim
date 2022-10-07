-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-context'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- test
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "rouge8/neotest-rust"
        }
    }

    -- cmp
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- Colorschemes
    use 'folke/tokyonight.nvim'
    use 'ellisonleao/gruvbox.nvim' 
    use 'luisiacc/gruvbox-baby' 
    use 'joshdick/onedark.vim'

    use 'linty-org/readline.nvim'

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    use({
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    -- Terminal
    -- use { "numToStr/FTerm.nvim", cmd = 'FTerm' }
    use { 
        "numToStr/FTerm.nvim",
        config = function()
            vim.api.nvim_create_user_command('FTermToggle', require('FTerm').toggle, { bang = true })
        end,
        cmd = 'FTermToggle'
    }

    -- git
    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
end)
