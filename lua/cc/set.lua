vim.g.mapleader = " "
vim.g.maplocalleader = " m"

local opt = vim.opt

opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.foldenable = false

vim.o.conceallevel = 2

-- vim.o.foldcolumn = "1"
-- vim.o.foldlevel = 99
-- vim.o.foldlevelstart = 99
-- vim.o.foldenable = true

-- vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.clipboard = "unnamedplus"

vim.o.cursorline = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.undofile = true

vim.o.winwidth = 10
vim.o.winminwidth = 10
vim.o.winheight = 5
vim.o.winminheight = 5

vim.filetype.add({
    extension = {
        tpl = "json",
    },
})
