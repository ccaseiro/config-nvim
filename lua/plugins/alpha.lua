return {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>hh", "<cmd>Alpha<cr>", desc = "Dashboard" },
        { "<leader>bh", "<cmd>Alpha<cr>", desc = "Dashboard" },
    },
    opts = function()
        local dashboard = require("alpha.themes.dashboard")
        -- local dashboard = require("alpha.themes.startify")
        dashboard.section.buttons.val = {
            dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
            dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("i", " " .. " Notes (index)", ":Neorg index<CR>"),
            dashboard.button("p", " " .. " Projects", ":Telescope project<CR>"),
            dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
            dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
            dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
            -- dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
            dashboard.button("s", " " .. " Restore Session", [[:lua require("mini.sessions").read() <cr>]]),
            dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
            dashboard.button("q", " " .. " Quit", ":qa<CR>"),
        }

        return dashboard
    end,
    config = function(_, dashboard)
        require("alpha").setup(dashboard.opts)
    end,
}
