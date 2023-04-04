require("toggleterm").setup({
    size = 25,
    start_in_insert = true,
    open_mapping = [[<c-n>]],
    direction = "horizontal",
})

local Terminal = require("toggleterm.terminal").Terminal

local node = Terminal:new({ cmd = "node", direction = "float", hidden = true })
function _NODE_TOGGLE()
    node:toggle()
end

local python = Terminal:new({ cmd = "python", direction = "float", hidden = true })
function _PYTHON_TOGGLE()
    python:toggle()
end

local htop = Terminal:new({ cmd = "htop", direction = "float", hidden = true })
function _HTOP_TOGGLE()
    htop:toggle()
end

local lazygit = Terminal:new({ cmd = "lazygit", direction = "float", hidden = true })
function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

local ncdu = Terminal:new({ cmd = "ncdu", direction = "float", hidden = true })
function _NCDU_TOGGLE()
    ncdu:toggle()
end
