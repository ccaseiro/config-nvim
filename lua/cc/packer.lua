local wk = require("which-key")

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


-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

vim.cmd(
[[
augroup packer_user_config
autocmd!
autocmd BufWritePost packer.lua source <afile> | PackerSync
augroup end
]]
)

-- packer.nvim configuration
local conf = {
    profile = {
        enable = true,
        threshold = 0 -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
    display = {
        open_fn = function()
            return require("packer.util").float {border = "rounded"}
        end
    }
}

local packer = require "packer"
packer.init(conf)
return packer.startup(function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    use 'tpope/vim-unimpaired'
    use 'justinmk/vim-sneak'
    -- use {
    --     'ggandor/leap.nvim',
    --     config = function()
    --         require('leap').add_default_mappings()
    --     end
    -- }

    use({"L3MON4D3/LuaSnip"})

    use {
        "neovim/nvim-lspconfig", 
        wants = {"null-ls"},
        requires = {"jose-elias-alvarez/null-ls.nvim"}
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-treesitter-context"

    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        -- or                            , branch = '0.1.x',
        requires = {
            {"nvim-lua/plenary.nvim"},
            -- { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            { "natecraddock/telescope-zf-native.nvim"},
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "nvim-telescope/telescope-project.nvim" }
        }
    }

    -- project
    use {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    -- test
    use {
        "nvim-neotest/neotest",
        tag = "v2.2.0",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "rouge8/neotest-rust",
            "haydenmeade/neotest-jest"
        }
    }

    -- cmp
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"
    use "saadparwaiz1/cmp_luasnip"

    -- editing
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    -- Colorschemes
    use "folke/tokyonight.nvim"
    use "ellisonleao/gruvbox.nvim"
    use "luisiacc/gruvbox-baby"
    use "joshdick/onedark.vim"

    use {
        "nvim-lualine/lualine.nvim",
        -- requires = {"kyazdani42/nvim-web-devicons", opt = true},
        requires = {"kyazdani42/nvim-web-devicons"},
        config = function()
            require("lualine").setup()
        end
    }

    use "linty-org/readline.nvim"

    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    }

    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {}
        end
    }

    use(
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end
    }
    )

    -- Terminal
    -- use { "numToStr/FTerm.nvim", cmd = 'FTerm' }
    -- use {
    --     "numToStr/FTerm.nvim",
    --     config = function()
    --         vim.api.nvim_create_user_command("FTermToggle", require("FTerm").toggle, {bang = true})
    --     end,
    --     cmd = "FTermToggle"
    -- }
    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("cc/toggleterm")
    end}

    -- git
    use {"TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim"}
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
                -- current_line_blame_opts = {
                --     virt_text = true,
                --     virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                --     delay = 1000,
                --     ignore_whitespace = false,
                -- },
                -- current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',

                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, {expr=true})

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, {expr=true})

                    -- Actions
                    -- map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
                    -- map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
                    map('n', '<leader>hS', gs.stage_buffer)
                    map('n', '<leader>hu', gs.undo_stage_hunk)
                    map('n', '<leader>hR', gs.reset_buffer)
                    -- map('n', '<leader>hp', gs.preview_hunk)
                    -- map('n', '<leader>hb', function() gs.blame_line{full=true} end)
                    -- map('n', '<leader>tb', gs.toggle_current_line_blame)
                    map('n', '<leader>hd', gs.diffthis)
                    map('n', '<leader>hD', function() gs.diffthis('~') end)
                    map('n', '<leader>td', gs.toggle_deleted)

                    -- Text object
                    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end
            })
        end
    }
    if packer_bootstrap then
        print "Setting up Neovim. Restart required after installation!"
        require('packer').sync()
    end

    use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}
end
)
