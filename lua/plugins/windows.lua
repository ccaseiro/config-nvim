return {
    -- {
    --     "anuvyklack/windows.nvim",
    --     lazy = false,
    --     dependencies = {
    --         "anuvyklack/middleclass",
    --         "anuvyklack/animation.nvim",
    --     },
    --     keys = {
    --         { "<leader>wm", "<cmd>WindowsMaximize<cr>", desc = "Maximize" },
    --         { "<leader>tm", "<cmd>WindowsToggleAutowidth<cr>", desc = "toggle windows autowidth" },
    --     },
    --     config = function()
    --         vim.o.winwidth = 10
    --         vim.o.winminwidth = 10
    --         vim.o.equalalways = false
    --         require("windows").setup({
    --             autowidth = {
    --                 enable = false,
    --             },
    --         })
    --     end,
    -- },
    -- {
    --     "beauwilliams/focus.nvim",
    --     lazy = false,
    --     keys = {
    --         { "<leader>wm", "<cmd>FocusMaxOrEqual<cr>", desc = "Focus Toggle" },
    --         { "<leader>wz", "<cmd>FocusToggle<cr>", desc = "Focus Toggle" },
    --     },
    --     config = function()
    --         require("focus").setup({
    --             signcolumn = false,
    --         })
    --     end,
    -- },
    {
        "nvim-zh/colorful-winsep.nvim",
        config = true,
        event = { "WinNew" },
    },
    {
        "sindrets/winshift.nvim",
        -- lazy = false,
        keys = {
            { "<leader>wa", "<cmd>WinShift<cr>", desc = "WinShift" },
            { "<leader>wf", "<cmd>WinShift swap<cr>", desc = "WinShift swap" },
        },
        config = function()
            require("winshift").setup({
                window_picker = function()
                    return require("winshift.lib").pick_window({
                        picker_chars = "NEIOYMABCDFGHJKLPQRSTUVWXZ1234567890",
                    })
                end,
            })
        end,
    },
}
