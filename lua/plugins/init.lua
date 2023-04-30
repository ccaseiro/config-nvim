return {
    "tpope/vim-unimpaired",
    -- makes some plugins dot-repeatable like leap
    { "tpope/vim-repeat", event = "VeryLazy" },

    -- surround
    {
        "echasnovski/mini.surround",
        keys = function(_, keys)
            -- Populate the keys based on the user's options
            local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
            local opts = require("lazy.core.plugin").values(plugin, "opts", false)
            local mappings = {
                { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
                { opts.mappings.delete, desc = "Delete surrounding" },
                { opts.mappings.find, desc = "Find right surrounding" },
                { opts.mappings.find_left, desc = "Find left surrounding" },
                { opts.mappings.highlight, desc = "Highlight surrounding" },
                { opts.mappings.replace, desc = "Replace surrounding" },
                { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
            }
            mappings = vim.tbl_filter(function(m)
                return m[1] and #m[1] > 0
            end, mappings)
            return vim.list_extend(mappings, keys)
        end,
        opts = {
            mappings = {
                add = "gza", -- Add surrounding in Normal and Visual modes
                delete = "gzd", -- Delete surrounding
                find = "gzf", -- Find surrounding (to the right)
                find_left = "gzF", -- Find surrounding (to the left)
                highlight = "gzh", -- Highlight surrounding
                replace = "gzr", -- Replace surrounding
                update_n_lines = "gzn", -- Update `n_lines`
            },
        },
        config = function(_, opts)
            -- use gz mappings instead of s to prevent conflict with leap
            require("mini.surround").setup(opts)
        end,
    },
    {
        "echasnovski/mini.bufremove",
        -- stylua: ignore
        keys = {
            { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
            { "<leader>bk", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
            { "<leader>bK", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
        },
    },

    {
        "ggandor/leap.nvim",
        dependencies = "tpope/vim-repeat",
        keys = {
            { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
            { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
            { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
        },
        config = function(_, opts)
            local leap = require("leap")
            for k, v in pairs(opts) do
                leap.opts[k] = v
            end
            leap.add_default_mappings(true)
            vim.keymap.del({ "x", "o" }, "x")
            vim.keymap.del({ "x", "o" }, "X")
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
    -- { "neovim/nvim-lspconfig", dependencies = { "jose-elias-alvarez/null-ls.nvim" } },
    { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
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
        "L3MON4D3/LuaSnip",
        config = function()
            require("cc.luasnip")
        end,
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

    "linty-org/readline.nvim",

    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("cc/toggleterm")
        end,
    },

    -- session management
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
        -- stylua: ignore
        keys = {
            { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
        },
    },

    {
        "renerocksai/telekasten.nvim",
        lazy = false,
        dependencies = { "nvim-telescope/telescope.nvim" },
        keys = {
            {
                "<leader>np",
                "<cmd>Telekasten panel<cr>",
                desc = "panel",
            },
            {
                "<leader>nf",
                "<cmd>Telekasten find_notes<cr>",
                desc = "find notes",
            },
            {
                "<leader>ng",
                "<cmd>Telekasten search_notes<cr>",
                desc = "search notes",
            },
            {
                "<leader>nd",
                "<cmd>Telekasten goto_today<cr>",
                desc = "goto today",
            },
            {
                "<leader>ni",
                "<cmd>Telekasten follow_link<cr>",
                desc = "follow link",
            },
            {
                "<leader>nn",
                "<cmd>Telekasten new_note<cr>",
                desc = "new note",
            },
            {
                "<leader>nt",
                "<cmd>Telekasten toggle_todo<cr>",
                desc = "toggle todo",
            },
            {
                "<leader>nw",
                "<cmd>Telekasten goto_thisweek<cr>",
                desc = "goto this week",
            },
        },
        config = function()
            require("telekasten").setup({
                home = vim.fn.expand("~/Documents/Notes"), -- Put the name of your notes directory here
            })
        end,
    },
}
