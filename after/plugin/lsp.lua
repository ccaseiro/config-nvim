local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
end

lspconfig = require('lspconfig')

lspconfig.rust_analyzer.setup{
    on_attach = on_attach
}
lspconfig.taplo.setup{} -- toml

lspconfig.tsserver.setup{}
