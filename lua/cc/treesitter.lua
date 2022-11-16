-- treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "rust", "query", "javascript", "lua", "hcl" },

  highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
  },

  playground = {
      enable = true,
  }
}


