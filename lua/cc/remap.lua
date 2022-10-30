local nnoremap = require("cc.keymap").nnoremap
local vnoremap = require("cc.keymap").vnoremap

nnoremap("<leader>/", "<cmd>Telescope live_grep<CR>")

nnoremap("<leader>bd", "<cmd>bd<CR>")
nnoremap("<leader>bk", "<cmd>bd<CR>")

nnoremap("<leader>cr", vim.lsp.buf.rename)
nnoremap("K", vim.lsp.buf.hover)

nnoremap("<leader>fs", "<cmd>w<CR>")
nnoremap("<leader>fb", "<cmd>Telescope file_browser<CR>")

nnoremap("<leader>gg", "<cmd>Neogit<CR>")

nnoremap("<leader>mtf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>")
nnoremap("<leader>mto", "<cmd>lua require('neotest').output.open({ enter = true })<cr>")
nnoremap("<leader>mts", "<cmd>lua require('neotest').summary.toggle()<cr>")
nnoremap("<leader>mtt", "<cmd>lua require('neotest').run.run()<cr>")

nnoremap("<leader>o-", "<cmd>Ex<CR>")

nnoremap("<leader>pp", "<cmd>Telescope project<CR>")

nnoremap("<leader>qq", "<cmd>qa<CR>")

nnoremap("<leader>wc", "<C-w>c")
nnoremap("<leader>ws", "<cmd>split<CR>")
nnoremap("<leader>wv", "<cmd>vsplit<CR>")
nnoremap("<leader>ww", "<C-w>w")
nnoremap("<leader>wl", "<C-w>l")
nnoremap("<leader>wh", "<C-w>h")
nnoremap("<leader>wk", "<C-w>k")
nnoremap("<leader>wj", "<C-w>j")
nnoremap("<leader>wo", "<C-w>o")
nnoremap("<leader>w=", "<C-w>=")
-- Go to window 1,2,3,4
nnoremap("<leader>wn", "1<C-w>w")
nnoremap("<leader>we", "2<C-w>w")
nnoremap("<leader>wi", "3<C-w>w")
nnoremap("<leader>wy", "4<C-w>w")

nnoremap("<leader>.", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fr", "<cmd>Telescope oldfiles<cr>")
nnoremap("<leader>bb", "<cmd>Telescope buffers<cr>")

-- nnoremap("<leader>ot", "<cmd>lua require('FTerm').toggle()<cr>") -- toggle terminal
-- nnoremap("<leader>ot", "<cmd>FTermToggle<cr>") -- toggle terminal
vim.api.nvim_set_keymap("n", "<leader>ot", "<cmd>ToggleTerm<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>of", "<cmd>ToggleTerm direction=float<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>os", "<cmd>ToggleTerm direction=horizontal<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>ov", "<cmd>ToggleTerm direction=vertical<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<leader>oo1", "<cmd>ToggleTerm 1<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>oo2", "<cmd>ToggleTerm 2<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<leader>oon", "<cmd>lua _NCDU_TOGGLE()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>ool", "<cmd>lua _LAZZYGIT_TOGGLE()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>oon", "<cmd>lua _NODE_TOGGLE()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>oop", "<cmd>lua _PYTHON_TOGGLE()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>ooh", "<cmd>lua _HTOP_TOGGLE()<CR>", {noremap = true, silent = true})

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
