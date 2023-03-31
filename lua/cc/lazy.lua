local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local plugins = {
    "tpope/vim-unimpaired",
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end,
    },

    -- Colorschemes
    "folke/tokyonight.nvim",
    "ellisonleao/gruvbox.nvim",
    "luisiacc/gruvbox-baby",
    "joshdick/onedark.vim",

    {
        "nvim-lualine/lualine.nvim",
        -- requires = {"kyazdani42/nvim-web-devicons", opt = true},
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup()
        end,
    },

    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup()
        end,
    },
    { "neovim/nvim-lspconfig", dependencies = { "jose-elias-alvarez/null-ls.nvim" } },
    { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({})
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            -- { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            { "natecraddock/telescope-zf-native.nvim" },
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "nvim-telescope/telescope-project.nvim" },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
        config = function()
            require("cc.telescope")
        end,
    },
    -- project
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({
                patterns = { ".git/submodules" },
            })
        end,
    },

    {
        "m-demare/attempt.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/playground",
        },
        config = function()
            require("attempt").setup()
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = "nvim-treesitter/nvim-treesitter-context",
        build = ":TSUpdate",
        config = function()
            require("cc.treesitter")
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("cc.luasnip")
        end,
    },

    -- test
    {
        "nvim-neotest/neotest",
        tag = "v2.2.0",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "rouge8/neotest-rust",
            "haydenmeade/neotest-jest",
        },
    },

    -- cmp
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "saadparwaiz1/cmp_luasnip",
    -- editing
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        -- branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    bind_to_cwd = false,
                    follow_current_file = true,
                },
                window = {
                    mappings = {
                        ["<space>"] = "none",
                    },
                },
                default_component_configs = {
                    indent = {
                        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                        expander_collapsed = "",
                        expander_expanded = "",
                        expander_highlight = "NeoTreeExpander",
                    },
                },
            })
        end,
    },
    "linty-org/readline.nvim",

    -- git
    { "TimUntersberger/neogit", dependencies = "nvim-lua/plenary.nvim" },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
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
                    map("n", "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    map("n", "[c", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    -- Actions
                    -- map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
                    -- map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
                    map("n", "<leader>hS", gs.stage_buffer)
                    map("n", "<leader>hu", gs.undo_stage_hunk)
                    map("n", "<leader>hR", gs.reset_buffer)
                    -- map('n', '<leader>hp', gs.preview_hunk)
                    -- map('n', '<leader>hb', function() gs.blame_line{full=true} end)
                    -- map('n', '<leader>tb', gs.toggle_current_line_blame)
                    map("n", "<leader>hd", gs.diffthis)
                    map("n", "<leader>hD", function()
                        gs.diffthis("~")
                    end)
                    map("n", "<leader>td", gs.toggle_deleted)

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                end,
            })
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("cc/toggleterm")
        end,
    },
}

require("lazy").setup(plugins)
