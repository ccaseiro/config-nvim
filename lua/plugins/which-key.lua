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
            ["<leader>b"] = { name = "+buffer" },
            ["<leader>c"] = { name = "+code" },
            ["<leader>f"] = { name = "+file/find" },
            ["<leader>g"] = { name = "+git" },
            ["<leader>gh"] = { name = "+hunks" },
            ["<leader>n"] = { name = "+notes" },
            ["<leader>p"] = { name = "+project" },
            ["<leader>q"] = { name = "+quit/session" },
            ["<leader>s"] = { name = "+search" },
            ["<leader>w"] = { name = "+windows" },
        }
        wk.register(keymaps)
    end,
}
