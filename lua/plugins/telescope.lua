return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    cmd = "Telescope",
    keys = {
        -- git
        { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
        { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
        -- search
        { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    },
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        -- { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "natecraddock/telescope-zf-native.nvim" },
        { "nvim-telescope/telescope-file-browser.nvim" },
        { "nvim-telescope/telescope-project.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        "debugloop/telescope-undo.nvim",
    },
    config = function()
        local fb_actions = require("telescope").extensions.file_browser.actions
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                file_ignore_patterns = { "node_modules" },
                -- mappings = {
                --     i = {
                --         -- map actions.which_key to <C-h> (default: <C-/>)
                --         -- actions.which_key shows the mappings for your picker,
                --         -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                --         ["<C-h>"] = "which_key"
                --     }
                -- }
            },
            extensions = {
                file_browser = {
                    mappings = {
                        ["i"] = {
                            -- ["<C-c>"] = fb_actions.create,
                            ["<C-x>"] = fb_actions.create,
                            ["<C-d>"] = fb_actions.remove,
                        },
                    },
                },
                undo = {
                    side_by_side = true,
                    layout_strategy = "vertical",
                    layout_config = {
                        preview_height = 0.8,
                    },
                    mappings = {
                        i = {
                            ["<cr>"] = require("telescope-undo.actions").yank_additions,
                            ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                            ["<C-x>"] = require("telescope-undo.actions").restore,
                        },
                        n = {
                            ["y"] = require("telescope-undo.actions").yank_additions,
                            ["Y"] = require("telescope-undo.actions").yank_deletions,
                            ["u"] = require("telescope-undo.actions").restore,
                        },
                    },
                },
            },
        })
        telescope.load_extension("zf-native")
        telescope.load_extension("file_browser")
        telescope.load_extension("project")
        telescope.load_extension("attempt")
        telescope.load_extension("ui-select")
        telescope.load_extension("undo")
    end,
}
