require("cc.set")
require("cc.packer")
require("cc.remap")

vim.api.nvim_create_autocmd({"BufWritePre"}, {command = "lua vim.lsp.buf.format()", })
-- vim.api.nvim_create_autocmd({"BufWritePre"}, {pattern = "*.rs", command = "lua vim.lsp.buf.format()", })
-- vim.api.nvim_create_autocmd("BufWritePre", { pattern="*.rs", callback = function() vim.lsp.buf.format() end })

