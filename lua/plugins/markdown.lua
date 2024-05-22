return {
    "dhruvasagar/vim-table-mode",
    lazy = false,
    ft = "markdown", -- only load plugin when markdown file opens
    -- init = function()
    --     -- Avoid polluting <leader>t mappings. (keep <leader>tm for enable)
    --     vim.g.table_mode_disable_tableize_mappings = 1
    --
    --     -- FIX: Really slow performance: https://github.com/dhruvasagar/vim-table-mode/issues/227
    --     vim.g.table_mode_syntax = 0
    --
    --     vim.g.table_mode_corner = "|"
    -- end,
    config = function()
        -- these are dumb
        vim.keymap.del("v", "<leader>T")
        vim.keymap.del("v", "<leader>tt")
        vim.keymap.del("n", "<leader>tt")
        -- vim.keymap.del("n", "<leader>tm")

        -- remove mappings I don't use
        -- vim.g.table_mode_disable_mappings = 1
        -- vim.g.table_mode_disable_tableize_mappings = 0
    end,
}
