return {
    {
        "echasnovski/mini.files",
        lazy = false,
        version = false,
        keys = {
            {
                "<leader>fF",
                function()
                    require("mini.files").open()
                end,
                desc = "mini.files",
            },
            {
                "<leader>ff",
                function()
                    require("mini.files").open(vim.api.nvim_buf_get_name(0))
                end,
                desc = "mini.files",
            },
        },
    },
    {
        "stevearc/oil.nvim",
        lazy = false,
        opts = {
            columns = {
                "icon",
                -- "permissions",
                -- "size",
                -- "mtime",
            },
            default_file_explorer = true,
            float = {
                -- Padding around the floating window
                padding = 10,
                max_width = 112,
                max_height = 70,
                -- max_width = 0,
                -- max_height = 0,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
                -- This is the config that will be passed to nvim_open_win.
                -- Change values here to customize the layout
                override = function(conf)
                    return conf
                end,
            },
        },
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            {
                "-",
                "<CMD>Oil<CR>",
                desc = "Oil",
            },
            {
                "<leader>i",
                "<cmd>lua require('oil').toggle_float()<CR>",
                desc = "Oil",
            },
        },
    },
}
