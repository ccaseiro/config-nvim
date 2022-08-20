local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
end

require'lspconfig'.rust_analyzer.setup{
    on_attach = on_attach
}
require'lspconfig'.taplo.setup{} -- toml

