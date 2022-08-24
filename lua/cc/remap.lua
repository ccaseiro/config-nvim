local nnoremap = require("cc.keymap").nnoremap
local vnoremap = require("cc.keymap").vnoremap

nnoremap("<leader>bd", "<cmd>bd<CR>")
nnoremap("<leader>bk", "<cmd>bd<CR>")

nnoremap("<leader>fs", "<cmd>w<CR>")

nnoremap("<leader>gg", "<cmd>Neogit<CR>")

nnoremap("<leader>mtf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>")
nnoremap("<leader>mto", "<cmd>lua require('neotest').output.open({ enter = true })<cr>")
nnoremap("<leader>mts", "<cmd>lua require('neotest').summary.toggle()<cr>")
nnoremap("<leader>mtt", "<cmd>lua require('neotest').run.run()<cr>")

nnoremap("<leader>o-", "<cmd>Ex<CR>")

nnoremap("<leader>qq", "<cmd>qa<CR>")

nnoremap("<leader>wc", "<cmd>close<CR>")

nnoremap("<leader>.", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fr", "<cmd>Telescope oldfiles<cr>")
nnoremap("<leader>bb", "<cmd>Telescope buffers<cr>")

nnoremap("<leader>ot", "<cmd>lua require('FTerm').toggle()<cr>") -- toggle terminal

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
