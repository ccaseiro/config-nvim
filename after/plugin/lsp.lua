local nnoremap = require("cc.keymap").nnoremap
local map = require("cc.keymap").map
local nls = require("null-ls")

local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.hover, bufopts)

    nnoremap("gd", "<cmd>Telescope lsp_definitions<cr>")
    nnoremap("gD", "<cmd>Telescope lsp_references<cr>")
    map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
end

lspconfig = require("lspconfig")

local servers = { "gopls", "rust_analyzer", "taplo", "tsserver", "terraformls" }

lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
})
lspconfig.taplo.setup({}) -- toml

lspconfig.tsserver.setup({
    -- formatter = "prettier"
    on_attach = on_attach,
})

lspconfig.terraformls.setup({
    on_attach = on_attach,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

for _, ls in ipairs(servers) do
    require("lspconfig")[ls].setup({
        capabilities = capabilities,
        -- other_fields = ...
        on_attach = on_attach,
    })
end

require("ufo").setup()
