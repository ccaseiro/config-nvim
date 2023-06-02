local nnoremap = require("cc.keymap").nnoremap
local tnoremap = require("cc.keymap").tnoremap
local vnoremap = require("cc.keymap").vnoremap
local map = require("cc.keymap").map
local wk = require("which-key")

map("n", "<leader>/", "<cmd>Telescope live_grep<CR>", { desc = "Search project" })

-- nnoremap("<leader>bd", "<cmd>bp | sp | bn | bd<CR>")
-- nnoremap("<leader>bk", "<cmd>bp | sp | bn | bd<CR>")
-- nnoremap("<leader>bk", "<cmd>bd<CR>")

nnoremap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
vnoremap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
-- wk.register({["<leader>ca"] = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "code action"}})
wk.register({ ["<leader>cr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "rename" } })
wk.register({ ["<leader>cD"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "line diagnostics" } })
wk.register({ ["<leader>cd"] = { "<cmd>Telescope diagnostics<cr>", "diagnostics" } })
wk.register({ ["<leader>cs"] = { "<cmd>Telescope lsp_document_symbols<cr>", "document symbols" } })
wk.register({ ["<leader>ci"] = { "<cmd>Telescope lsp_incoming_calls<cr>", "incoming calls" } })
wk.register({ ["<leader>co"] = { "<cmd>Telescope lsp_outgoing_calls<cr>", "outgoing calls" } })
wk.register({ ["<leader>cI"] = { "<cmd>LspInfo<cr>", "lsp info" } })

wk.register({
    ["<leader>cwl"] = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "workspace list" },
})
wk.register({ ["<leader>cwa"] = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "workspace add" } })
wk.register({ ["<leader>cwr"] = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "workspace remove" } })

nnoremap("K", vim.lsp.buf.hover)
nnoremap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

-- nnoremap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
-- nnoremap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
-- nnoremap("[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>")
-- nnoremap("]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>")

nnoremap("<leader>bb", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>gg", "<cmd>Neogit<CR>")

-- wk.register({["<leader>fs"] = {"<cmd>w<CR>", "Save file"}})
map("n", "<leader>f.", "<cmd>lcd %:p:h<cr>", { desc = "cwd to file's directory" })
wk.register({ ["<leader>fb"] = { "<cmd>Telescope file_browser<CR>", "File browser" } })
wk.register({ ["<leader>fd"] = { "<cmd>Telescope file_browser path=%:p:h<CR>", "Find directory" } })
wk.register({ ["<leader>."] = { "<cmd>Telescope file_browser path=%:p:h<CR>", "File find" } })
wk.register({ ["<leader>ff"] = { "<cmd>Telescope file_browser path=%:p:h<CR>", "File browser" } })
wk.register({ ["<leader>fF"] = { "<cmd>Telescope find_files cwd=%:p:h<cr>", "File browser" } })
wk.register({ ["<leader>fg"] = { "<cmd>Telescope git_files<cr>", "File browser" } })
wk.register({ ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Recent files" } })
wk.register({ ["<leader>fy"] = { '<cmd>let @+ = expand("%:p")<CR>', "Yank file path" } })
wk.register({ ["<leader><leader>"] = { "<cmd>Telescope find_files<cr>", "File find" } })

-- wk.register({ ["<leader>ghb"] = { ":Gitsigns blame_line<cr>", "blame line" } })
-- wk.register({ ["<leader>ghp"] = { ":Gitsigns preview_hunk<cr>", "previw hunk" } })
-- wk.register({ ["<leader>ghP"] = { ":Gitsigns preview_hunk_inline<cr>", "previw hunk inline" } })
-- wk.register({ ["<leader>ghr"] = { ":Gitsigns reset_hunk<cr>", "reset hunk" } }, { mode = { "n", "v" } })
-- wk.register({ ["<leader>ghs"] = { ":Gitsigns stage_hunk<cr>", "stage hunk" } }, { mode = { "n", "v" } })
-- wk.register({ ["<leader>ghx"] = { ":Gitsigns reset_hunk<cr>", "reset hunk" } }, { mode = { "n", "v" } })

-- toggle options
map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Git Blame" })
map("n", "<leader>ts", require("cc.util").toggle, { desc = "Toggle format on Save" })

-- wk.register({ ["<leader>m"] = { name = "+localleader" } })

wk.register({ ["<leader>mt"] = { name = "+test" } })

nnoremap("<leader>o-", "<cmd>Ex<CR>")

-- project
nnoremap("<leader>pP", "<cmd>Telescope project<CR>")

nnoremap("<leader>qq", "<cmd>qa<CR>")

-- nnoremap("<leader>wc", "<C-w>c")
-- nnoremap("<leader>ws", "<cmd>split<CR>")
-- nnoremap("<leader>wv", "<cmd>vsplit<CR>")
nnoremap("<leader>ww", "<C-w>w")
nnoremap("<leader>wl", "<C-w>l")
nnoremap("<leader>wh", "<C-w>h")
nnoremap("<leader>wk", "<C-w>k")
nnoremap("<leader>wj", "<C-w>j")
-- nnoremap("<leader>wm", "<C-w>o")
map("n", "<leader>wm", "<C-w>| <C-w>_", { desc = "max width" })
map("n", "<leader>wo", "<C-w>|", { desc = "max width" })
map("n", "<leader>w_", "<C-w>_", { desc = "max height" })
nnoremap("<leader>w=", "<C-w>=")
-- Go to window 1,2,3,4
nnoremap("<leader>wn", "1<C-w>w")
nnoremap("<leader>we", "2<C-w>w")
nnoremap("<leader>wi", "3<C-w>w")
nnoremap("<leader>wy", "4<C-w>w")
-- Rotate
nnoremap("<leader>wr", "<C-w>r")
nnoremap("<leader>wx", "<C-w>x")
nnoremap("<leader>wR", "<C-w>R")
nnoremap("<leader>wH", "<C-w>H")
nnoremap("<leader>wJ", "<C-w>J")
nnoremap("<leader>wK", "<C-w>K")
nnoremap("<leader>wL", "<C-w>L")
-- nnoremap("<leader>wfh", "-2<C-w>x")
-- nnoremap("<leader>wfl", "2<C-w>x")

-- nnoremap("<leader>ot", "<cmd>lua require('FTerm').toggle()<cr>") -- toggle terminal
-- nnoremap("<leader>ot", "<cmd>FTermToggle<cr>") -- toggle terminal

-- wk.register({["<C-n>"] = {"<cmd>ToggleTermToggleAll<CR>", "ToggleTermToggleAll"}}, {mode={"n", "t"}})

vim.api.nvim_set_keymap("n", "<leader>ot", "<cmd>ToggleTermToggleAll<CR>", { noremap = true, silent = true })
wk.register({ ["<C-y>"] = { "<cmd>ToggleTermToggleAll<CR>", "ToggleTermToggleAll" } }, { mode = { "n", "t" } })

vim.api.nvim_set_keymap("n", "<leader>of", "<cmd>ToggleTerm direction=float<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>os",
    "<cmd>ToggleTerm direction=horizontal<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>ov", "<cmd>ToggleTerm direction=vertical<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>oo1", "<cmd>ToggleTerm 1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>oo2", "<cmd>ToggleTerm 2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>oo3", "<cmd>ToggleTerm 3<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>ooe", "<cmd>ToggleTermSendVisualSelection<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ool", "<cmd>ToggleTermSendCurrentLine<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>oon", "<cmd>lua _NCDU_TOGGLE()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>oog", "<cmd>lua _LAZZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>oon", "<cmd>lua _NODE_TOGGLE()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>oop", "<cmd>lua _PYTHON_TOGGLE()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ooh", "<cmd>lua _HTOP_TOGGLE()<CR>", { noremap = true, silent = true })

vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])

-- fold: ufo
wk.register({ ["zR"] = { "<cmd>lua require('ufo').openAllFolds()<cr>", "Open all folds" } })
wk.register({ ["zM"] = { "<cmd>lua require('ufo').closeAllFolds()<cr>", "Close all folds" } })

-- Paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dP')

-- terminal
tnoremap("<C-k>", [[<C-\><C-n><C-w>k]])
tnoremap("<C-j>", [[<C-\><C-n><C-w>j]])
-- tnoremap("<C-l>", [[<C-\><C-n><C-w>l]])
-- tnoremap("<C-h>", [[<C-\><C-n><C-w>h]])
nnoremap("<C-k>", [[<C-w>k]])
nnoremap("<C-j>", [[<C-w>j]])
nnoremap("<C-l>", [[<C-w>l]])
nnoremap("<C-h>", [[<C-w>h]])

wk.register({ ["<leader>x"] = { "<cmd>Telescope attempt<cr>", "List Scratch buffers" } })
wk.register({ ["<leader>bx"] = { "<cmd>lua require('attempt').new_select()<cr>", "New Scratch buffers" } })

--------------------------------------------------------------------------------

-- save file
map({ "n" }, "<leader>fs", "<cmd>w<cr><esc>", { desc = "Save file" })

-- yank all buffer
map({ "n" }, "<leader>by", "<cmd>%y+<cr>", { desc = "Yank Buffer" })
map({ "n" }, "<leader>bv", "ggVG", { desc = "Select Buffer" })

-- windows
map("n", "<leader>wc", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>ws", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>wv", "<C-W>v", { desc = "Split window right" })

-- seaarch
map("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Goto Symbol" })
map("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffer" })

-- telescope
map("n", "<leader>'", "<cmd>Telescope resume<cr>", { desc = "Resume" })

map("n", "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", { desc = "Switch Buffer" })
map("n", "<leader>:", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Help Pages" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
map("n", "<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
map("n", "<leader>sm", "<cmd>Telescope marks<cr>", { desc = "Jump to Mark" })
map("n", "<leader>so", "<cmd>Telescope vim_options<cr>", { desc = "Options" })
map("n", "<leader>sR", "<cmd>Telescope resume<cr>", { desc = "Resume" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Mason
map("n", "<leader>cm", "<cmd>Mason<cr>", { desc = "Mason" })

-- Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- map("n", "<C-l>", "<cmd>Noice dismiss<cr><cmd>noh<cr><C-l>", { desc = "New File" })
map("n", "<C-]>", "<cmd>Noice dismiss<cr><cmd>noh<cr><C-l>", { desc = "New File" })

-- buffers
map("n", "<leader>br", "<cmd>e!<cr>", { desc = "Revert Buffer" })
