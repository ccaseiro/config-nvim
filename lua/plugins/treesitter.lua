return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = "nvim-treesitter/nvim-treesitter-context",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            -- A list of parser names, or "all"
            ensure_installed = { "rust", "query", "javascript", "lua", "hcl", "yaml", "terraform", "python" },

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            playground = {
                enable = true,
            },

            matchup = {
                enable = true,
            },
        })
    end,
}
