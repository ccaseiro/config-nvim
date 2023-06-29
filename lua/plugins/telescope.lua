return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    cmd = "Telescope",
    keys = {
        -- git
        { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
        { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
        -- search
        { "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "Search Project" },
        { "<leader>'", "<cmd>Telescope resume<cr>", desc = "Resume" },

        { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
        { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
        { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>sC", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader>sd", "<cmd>Telescope live_grep cwd=%:p:h<CR>", desc = "Search file cwd" },
        { "<leader>sDD", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
        { "<leader>sDd", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
        { "<leader>sG", "<cmd>Telescope live_grep cwd=false<CR>", desc = "search cwd" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
        { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
        { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
        { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
        { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
        { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
        { "<leader>uC", "<cmd>Telescope colorscheme enable_preview=true<cr>", desc = "Colorscheme with preview" },
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
