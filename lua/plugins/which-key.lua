return {
    "folke/which-key.nvim",
    config = function()
        local wk = require("which-key")
        wk.setup(opts)
        local keymaps = {
            mode = { "n", "v" },
            ["g"] = { name = "+goto" },
            ["gz"] = { name = "+surround" },
            ["]"] = { name = "+next" },
            ["["] = { name = "+prev" },
            ["<leader><tab>"] = { name = "+tabs" },
            ["<leader>b"] = { name = "+buffer" },
            ["<leader>c"] = { name = "+code" },
            ["<leader>f"] = { name = "+file/find" },
            -- ["<leader>fp"] = { name = "+project" },
            ["<leader>g"] = { name = "+git" },
            ["<leader>gh"] = { name = "+hunks" },
            ["<leader>m"] = { name = "+<localleader>" },
            ["<leader>o"] = { name = "+open" },
            ["<leader>q"] = { name = "+quit/session" },
            ["<leader>s"] = { name = "+search" },
            ["<leader>sn"] = { name = "+noice" },
            ["<leader>w"] = { name = "+windows" },
        }
        wk.register(keymaps)
    end,
}
