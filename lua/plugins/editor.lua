return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        -- branch = "v2.x",
        cmd = "Neotree",
        keys = {
            {
                "<leader>fe",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
                end,
                desc = "Explorer NeoTree (Root Dir)",
            },
            {
                "<leader>fE",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
                end,
                desc = "Explorer NeoTree (cwd)",
            },
            { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
            { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
            {
                "<leader>ge",
                function()
                    require("neo-tree.command").execute({ source = "git_status", toggle = true })
                end,
                desc = "Git Explorer",
            },
            {
                "<leader>be",
                function()
                    require("neo-tree.command").execute({ source = "buffers", toggle = true })
                end,
                desc = "Buffer Explorer",
            },
        },
        -- _keys = {
        --     {
        --         "<leader>e",
        --         function()
        --             require("neo-tree.command").execute({ toggle = true, position = "float", dir = vim.loop.cwd() })
        --         end,
        --         desc = "Explorer NeoTree (cwd)",
        --     },
        --     {
        --         "<leader>E",
        --         function()
        --             require("neo-tree.command").execute({
        --                 toggle = true,
        --                 position = "float",
        --                 dir = vim.loop.os_homedir(),
        --             })
        --         end,
        --         desc = "Explorer NeoTree (Home)",
        --     },
        --     {
        --         "<leader>fe",
        --         function()
        --             require("neo-tree.command").execute({ position = "left", dir = vim.loop.cwd() })
        --         end,
        --         desc = "Explorer NeoTree (cwd)",
        --     },
        --     {
        --         "<leader>fE",
        --         function()
        --             require("neo-tree.command").execute({ position = "left", dir = vim.loop.os_homedir() })
        --         end,
        --         desc = "Explorer NeoTree (Home)",
        --     },
        --     {
        --         "<leader>ge",
        --         function()
        --             require("neo-tree.command").execute({ source = "git_status", toggle = true })
        --         end,
        --         desc = "Git Explorer",
        --     },
        --     {
        --         "<leader>be",
        --         function()
        --             require("neo-tree.command").execute({ source = "buffers", toggle = true })
        --         end,
        --         desc = "Buffer Explorer",
        --     },
        -- },

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
    -- Automatically highlights other instances of the word under your cursor.
    -- This works with LSP, Treesitter, and regexp matching to find the other
    -- instances.
    {
        "RRethy/vim-illuminate",
        -- event = "LazyFile",
        lazy = false,
        opts = {
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" },
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)

            local function map(key, dir, buffer)
                vim.keymap.set("n", key, function()
                    require("illuminate")["goto_" .. dir .. "_reference"](false)
                end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
            end

            map("]r", "next")
            map("[r", "prev")

            -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    map("]r", "next", buffer)
                    map("[r", "prev", buffer)
                end,
            })
        end,
        keys = {
            { "]r", desc = "Next Reference" },
            { "[r", desc = "Prev Reference" },
        },
    },
}
