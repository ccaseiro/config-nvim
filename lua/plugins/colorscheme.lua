return {
    "folke/tokyonight.nvim",
    "luisiacc/gruvbox-baby",
    "joshdick/onedark.vim",
    -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        "catppuccin/nvim",
        -- lazy = true,
        name = "catppuccin",
        opts = {
            integrations = {
                aerial = true,
                alpha = true,
                cmp = true,
                dashboard = true,
                flash = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                leap = true,
                lsp_trouble = true,
                mason = true,
                markdown = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                neotree = true,
                noice = true,
                notify = true,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
        },
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.cmd.colorscheme("gruvbox")
        end,
    },

    -- Configure LazyVim to load gruvbox
    -- {
    --     "LazyVim/LazyVim",
    --     opts = {
    --         colorscheme = "gruvbox",
    --     },
    -- },
}
