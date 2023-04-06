return {
    "ahmedkhalf/project.nvim",
    lazy = false,
    keys = {
        { "<leader>pp", "<cmd>lua require'telescope'.extensions.projects.projects{}<CR>", desc = "Switch project" },
    },
    config = function()
        require("project_nvim").setup({
            patterns = { ".git/submodules" },
        })
    end,
}
