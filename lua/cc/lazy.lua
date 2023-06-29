local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup("plugins")
-- require("lazy").setup({
--     spec = {
--         { "LazyVim/LazyVim", import = "lazyvim.plugins" },
--         -- import any extras modules here
--         { import = "lazyvim.plugins.extras.coding.yanky" },
--         -- import/override with your plugins
--         { import = "plugins" },
--     },
-- })
