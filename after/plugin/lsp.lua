local nnoremap = require("cc.keymap").nnoremap

local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.references, bufopts)
    nnoremap("gd", "<cmd>Telescope lsp_definitions<cr>")
    nnoremap("gD", "<cmd>Telescope lsp_references<cr>")
end

lspconfig = require('lspconfig')

local servers = {'rust_analyzer', 'taplo', 'tsserver', 'terraformls'}

lspconfig.rust_analyzer.setup{
    on_attach = on_attach
}
lspconfig.taplo.setup{} -- toml

lspconfig.tsserver.setup{
    -- formatter = "prettier"
    on_attach = on_attach
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

lspconfig.terraformls.setup{
    on_attach = on_attach
}

require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.shfmt,
    require("null-ls").builtins.formatting.prettier
  },
  debug = true
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

for _, ls in ipairs(servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities,
        -- other_fields = ...
    })
end



require('ufo').setup()
