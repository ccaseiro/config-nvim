require("cc.set")
require("cc.lazy")
require("cc.autocmds")
require("cc.remap")
require("cc.other")
vim.cmd([[command! -nargs=0 GoToFile :Telescope smart_open]])
-- vim.cmd([[command! -nargs=0 GoToFile :Telescope find_files]])
