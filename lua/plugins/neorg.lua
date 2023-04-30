return {
    {
        "nvim-neorg/neorg",
        cmd = "Neorg",
        -- keys = {
        --     {
        --         "<leader>ni",
        --         "<cmd>Neorg index<cr>",
        --         desc = "index",
        --     },
        -- },
        build = ":Neorg sync-parsers",
        opts = {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.norg.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        default_workspace = "notes",
                        workspaces = {
                            notes = "~/Documents/Notes",
                        },
                    },
                },
                ["core.integrations.telescope"] = {},
            },
        },
        dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
    },
}
