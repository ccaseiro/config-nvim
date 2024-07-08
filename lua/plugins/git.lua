return {
    {
        "FabijanZulj/blame.nvim",
        keys = {
            { "<leader>gB", "<cmd>BlameToggle<cr>", desc = "Current File History" },
        },
        opts = {
            date_format = "%Y-%m-%d %H:%M",
            max_summary_width = 50,
            format_fn = function(line_porcelain, config, idx)
                local author_initials = function(author_name)
                    return author_name:gsub("%a*%s*", function(c)
                        return string.upper(string.sub(c, 0, 1))
                    end)
                end

                local hash = string.sub(line_porcelain.hash, 0, 7)
                local line_with_hl = {}
                local is_commited = hash ~= "0000000"
                if is_commited then
                    local summary
                    if #line_porcelain.summary > config.max_summary_width then
                        summary = string.sub(line_porcelain.summary, 0, config.max_summary_width - 3) .. "..."
                    else
                        summary = line_porcelain.summary
                    end
                    line_with_hl = {
                        idx = idx,
                        values = {
                            {
                                textValue = hash,
                                hl = "Comment",
                            },
                            {
                                textValue = os.date(config.date_format, line_porcelain.committer_time),
                                hl = hash,
                            },
                            {
                                textValue = author_initials(line_porcelain.author),
                                hl = hash,
                            },
                            {
                                textValue = summary,
                                hl = hash,
                            },
                        },
                        format = "%s %s %s %s",
                    }
                else
                    line_with_hl = {
                        idx = idx,
                        values = {
                            {
                                textValue = "Not commited",
                                hl = "Comment",
                            },
                        },
                        format = "%s",
                    }
                end
                return line_with_hl
            end,
        },
    },
    {
        "sindrets/diffview.nvim",
        lazy = false,
        keys = {
            { "<leader>gdf", "<cmd>DiffviewFileHistory % --no-merges<cr>", desc = "Current File History" },
            {
                "<leader>gdp",
                "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>",
                desc = "Review PR",
            },
            {
                "<leader>gdc",
                "<cmd>DiffviewFileHistory --range=origin/HEAD...HEAD --right-only --no-merges<cr>",
                desc = "Review Individual PR Commits",
            },
            { "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = "Current Branch History" },
            { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
            { "<leader>gdq", "<cmd>DiffviewClose<cr>", desc = "Diffview close" },
            --
            { "<leader>gL", "<cmd>DiffviewFileHistory % --no-merges<cr>", desc = "Current File History" },
            {
                "<leader>gL",
                "<cmd>'<,'>:DiffviewFileHistory --no-merges<cr>",
                mode = "v",
                desc = "Current File History",
            },
            {
                "<leader>gP",
                "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>",
                desc = "Review PR",
            },
            { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Current Branch History" },
            { "<leader>gO", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
            { "<leader>gC", "<cmd>DiffviewClose<cr>", desc = "Diffview close" },
        },
    },
    {
        "NeogitOrg/neogit",
        -- branch = "nightly",
        dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
        opts = {
            disable_commit_confirmation = true,
            -- use_magit_keybindings = true
            -- sections = {
            --     untracked = {
            --         folded = true,
            --     },
            -- },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        opts = {
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                -- stylua: ignore start
                map("n", "]h", gs.next_hunk, "Next Hunk")
                map("n", "[h", gs.prev_hunk, "Prev Hunk")
                map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>ghP", gs.preview_hunk_inline, "Preview Hunk Inline")
                map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
                map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<leader>ghd", gs.diffthis, "Diff This")
                map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
                -- Toggle
                map('n', '<leader>gtb', gs.toggle_current_line_blame, "Toggle current line blame")
                map('n', '<leader>gtd', gs.toggle_deleted, "Toggle deleted")
                map('n', '<leader>gts', gs.toggle_signs, "Toggle sign column")
                map('n', '<leader>gtn', gs.toggle_numhl, "Toggle num highligth")
                map('n', '<leader>gtl', gs.toggle_linehl, "Toggle line highlight")
                map('n', '<leader>gtw', gs.toggle_word_diff, "Toggle word diff")
                -- Double map
                map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
            end,
        },
    },
    { "tpope/vim-fugitive" },
    -- {
    --     "SuperBo/fugit2.nvim",
    --     opts = {
    --         width = 100,
    --     },
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --         "nvim-tree/nvim-web-devicons",
    --         "nvim-lua/plenary.nvim",
    --         {
    --             "chrisgrieser/nvim-tinygit", -- optional: for Github PR view
    --             dependencies = { "stevearc/dressing.nvim" },
    --         },
    --     },
    --     cmd = { "Fugit2", "Fugit2Graph" },
    --     keys = {
    --         { "<leader>gf", mode = "n", "<cmd>Fugit2<cr>" },
    --     },
    -- },
    {
        -- optional: for diffview.nvim integration
        "sindrets/diffview.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- lazy, only load diffview by these commands
        cmd = {
            "DiffviewFileHistory",
            "DiffviewOpen",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
            "DiffviewRefresh",
        },
    },
}
