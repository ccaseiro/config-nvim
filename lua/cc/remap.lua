local nnoremap = require("cc.keymap").nnoremap

nnoremap("<leader>bd", "<cmd>bd<CR>")
nnoremap("<leader>bk", "<cmd>bd<CR>")

nnoremap("<leader>fs", "<cmd>w<CR>")

nnoremap("<leader>o-", "<cmd>Ex<CR>")

nnoremap("<leader>qq", "<cmd>qa<CR>")

nnoremap("<leader>.", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fr", "<cmd>Telescope oldfiles<cr>")
nnoremap("<leader>bb", "<cmd>Telescope buffers<cr>")
