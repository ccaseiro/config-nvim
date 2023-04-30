return {
    "nvim-telescope/telescope.nvim",
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
    },
    config = function()
        require("cc.telescope")
    end,
}
