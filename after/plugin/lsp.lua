local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
end

lspconfig = require('lspconfig')

lspconfig.rust_analyzer.setup{
    on_attach = on_attach
}
lspconfig.taplo.setup{} -- toml

lspconfig.tsserver.setup{
    -- formatter = "prettier"
}

-- local nls = require "null-ls"
-- local nls_b = nls.builtins
-- local nls_sources = {
--     nls_b.formatting.prettierd
--     -- nls_b.formatting.prettierd.with {
--     --     filetypes = { "html", "javascript", "json", "typescript", "yaml", "markdown" },
--     -- }
-- }
-- nls.setup {
--     sources = nls_sources
-- }

require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.shfmt,
    require("null-ls").builtins.formatting.prettier
  },
  debug = true
})


