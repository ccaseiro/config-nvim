local ts_select_dir_for_grep = function(prompt_bufnr)
    local action_state = require("telescope.actions.state")
    local fb = require("telescope").extensions.file_browser
    local live_grep = require("telescope.builtin").live_grep
    local current_line = action_state.get_current_line()

    fb.file_browser({
        files = false,
        depth = false,
        attach_mappings = function(prompt_bufnr)
            require("telescope.actions").select_default:replace(function()
                local entry_path = action_state.get_selected_entry().Path
                local dir = entry_path:is_dir() and entry_path or entry_path:parent()
                local relative = dir:make_relative(vim.fn.getcwd())
                local absolute = dir:absolute()

                live_grep({
                    results_title = relative .. "/",
                    cwd = absolute,
                    default_text = current_line,
                })
            end)

            return true
        end,
    })
end

---Ask the user for a folder / extension and use then in `live_grep`
-- https://github.com/JoosepAlviste/dotfiles/blob/be270814a726303a928dbcc8e57fa87579b96c3a/config/nvim/lua/j/plugins/telescope_custom_pickers.lua

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
        { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader>sd", "<cmd>Telescope live_grep cwd=%:p:h<CR>", desc = "Search file cwd" },
        {
            "<leader>sv",
            function()
                require("telescope.builtin").live_grep({ additional_args = { "--case-sensitive" } })
            end,
            desc = "Search file cwd",
        },
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
        { "nvim-telescope/telescope-live-grep-args.nvim" },
        "debugloop/telescope-undo.nvim",
    },
    config = function()
        local fb_actions = require("telescope").extensions.file_browser.actions
        local project_actions = require("telescope._extensions.project.actions")
        local mini_sessions = require("mini.sessions")
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
            pickers = {
                live_grep = {
                    mappings = {
                        i = {
                            ["<C-f>"] = ts_select_dir_for_grep,
                        },
                        n = {
                            ["<C-f>"] = ts_select_dir_for_grep,
                        },
                    },
                },
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
                project = {
                    on_project_selected = function(prompt_bufnr)
                        local project_name = project_actions.get_selected_title()
                        -- project_actions.find_project_files(prompt_bufnr, hidden_files)
                        project_actions.change_working_directory(prompt_bufnr, false)
                        -- if
                        --     pcall(function()
                        --         mini_sessions.read(project_name)
                        --     end)
                        -- then
                        --     print("Project + Session: " .. project_name)
                        -- else
                        --     print("Project: " .. project_name)
                        --     -- mini_sessions.read("default")
                        -- end
                    end,
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
        -- telescope.load_extension("project")
        telescope.load_extension("attempt")
        telescope.load_extension("ui-select")
        telescope.load_extension("undo")
        telescope.load_extension("live_grep_args")
    end,
}
