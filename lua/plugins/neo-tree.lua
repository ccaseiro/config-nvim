return {
    "nvim-neo-tree/neo-tree.nvim",
    -- branch = "v2.x",
    cmd = "Neotree",
    keys = {
        {
            "<leader>e",
            function()
                require("neo-tree.command").execute({ toggle = true, position = "float", dir = vim.loop.cwd() })
            end,
            desc = "Explorer NeoTree (cwd)",
        },
        {
            "<leader>E",
            function()
                require("neo-tree.command").execute({ toggle = true, position = "float", dir = vim.loop.os_homedir() })
            end,
            desc = "Explorer NeoTree (Home)",
        },
        {
            "<leader>fe",
            function()
                require("neo-tree.command").execute({ position = "left", dir = vim.loop.cwd() })
            end,
            desc = "Explorer NeoTree (cwd)",
        },
        {
            "<leader>fE",
            function()
                require("neo-tree.command").execute({ position = "left", dir = vim.loop.os_homedir() })
            end,
            desc = "Explorer NeoTree (Home)",
        },
    },

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
}
