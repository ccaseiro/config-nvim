local map = require("cc.keymap").map
local nnoremap = require("cc.keymap").nnoremap
local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.hover, bufopts)

    nnoremap("gd", "<cmd>Telescope lsp_definitions<cr>")
    nnoremap("gD", "<cmd>Telescope lsp_references<cr>")
    map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
end
return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            local nls = require("null-ls")
            local sources = {
                nls.builtins.formatting.shfmt,
                nls.builtins.formatting.prettier,
                -- nls.builtins.diagnostics.jshint,
                nls.builtins.diagnostics.eslint_d,
                nls.builtins.formatting.stylua,
            }
            nls.setup({
                sources = sources,
                on_attach = on_attach,
                debug = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        keys = {
            { "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
            { "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
            {
                "]e",
                "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>",
                desc = "Next Error",
            },
            {
                "[e",
                "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>",
                desc = "Prev Error",
            },
            --             nnoremap("[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>")
            -- nnoremap("]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>")
        },
        config = function(_, opts)
            for name, icon in pairs(require("cc.config").icons.diagnostics) do
                name = "DiagnosticSign" .. name
                vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
            end

            lspconfig = require("lspconfig")

            local on_new_config = function(_, config)
                vim.env.VIRTUAL_ENV = "/Users/ccaseiro/Developer/Outscope/vap-st-connector/lambdas/.venv"
                vim.env.PATH = "/Users/ccaseiro/Developer/Outscope/vap-st-connector/lambdas/.venv/bin:" .. vim.env.PATH
                vim.env.PYTHONHOME = ""
            end

            lspconfig.pyright.setup({
                on_attach = on_attach,
                on_new_config = on_new_config,
            })
        end,
    },
}
