return {
    {
        "NeogitOrg/neogit",
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
                map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
                map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<leader>ghd", gs.diffthis, "Diff This")
                map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end,
        },
        -- config = function()
        --     require("gitsigns").setup({
        --         -- current_line_blame_opts = {
        --         --     virt_text = true,
        --         --     virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        --         --     delay = 1000,
        --         --     ignore_whitespace = false,
        --         -- },
        --         -- current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        --
        --         on_attach = function(bufnr)
        --             local gs = package.loaded.gitsigns
        --
        --             local function map(mode, l, r, opts)
        --                 opts = opts or {}
        --                 opts.buffer = bufnr
        --                 vim.keymap.set(mode, l, r, opts)
        --             end
        --
        --             -- Navigation
        --             map("n", "]h", function()
        --                 if vim.wo.diff then
        --                     return "]h"
        --                 end
        --                 vim.schedule(function()
        --                     gs.next_hunk()
        --                 end)
        --                 return "<Ignore>"
        --             end, { expr = true, desc = "next hunk" })
        --
        --             map("n", "[h", function()
        --                 if vim.wo.diff then
        --                     return "[h"
        --                 end
        --                 vim.schedule(function()
        --                     gs.prev_hunk()
        --                 end)
        --                 return "<Ignore>"
        --             end, { expr = true, desc = "prev hunk" })
        --
        --             -- Actions
        --             -- map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
        --             -- map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
        --
        --             map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Unstage Stage" })
        --             map("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset Buffer" })
        --             map("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage Buffer" })
        --             map("n", "<leader>ghs", gs.stage_hunk, { desc = "Stage hunk" })
        --             map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview hunk" })
        --             map("n", "<leader>ghP", gs.preview_hunk_inline, { desc = "Preview hunk inline" })
        --             map("n", "<leader>ghb", function()
        --                 gs.blame_line({ full = true })
        --             end, { desc = "Blame line" })
        --             map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle blame" })
        --             map("n", "<leader>ghB", gs.toggle_current_line_blame, { desc = "Toggle blame" })
        --             map("n", "<leader>ghd", gs.diffthis, { desc = "Diff" })
        --             map("n", "<leader>ghD", function()
        --                 gs.diffthis("~")
        --             end, { desc = "Diff ~" })
        --             map("n", "<leader>ghx", gs.toggle_deleted, { desc = "Toggle deleted" })
        --
        --             -- Text object
        --             map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
        --         end,
        --     })
        -- end,
    },
    { "tpope/vim-fugitive" },
}
