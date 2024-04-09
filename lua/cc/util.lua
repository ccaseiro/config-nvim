local Util = require("lazy.core.util")
local M = {}

M.autoformat = true

function M.toggle()
    if vim.b.autoformat == false then
        vim.b.autoformat = nil
        M.autoformat = true
    else
        M.autoformat = not M.autoformat
    end
    if M.autoformat then
        Util.info("Enabled format on save", { title = "Format" })
    else
        Util.warn("Disabled format on save", { title = "Format" })
    end
end

M.var_toggle_01 = true

function M.toggle_01()
    M.var_toggle_01 = not M.var_toggle_01
    return M.var_toggle_01
    -- if vim.b.var_toggle_01 == false then
    --     vim.b.var_toggle_01 = nil
    --     M.var_toggle_01 = true
    -- else
    --     M.autoformat = not M.autoformat
    -- end
    -- if M.var_toggle_01 then
    --     Util.info("Enabled format on save", { title = "Format" })
    -- else
    --     Util.warn("Disabled format on save", { title = "Format" })
    -- end
end
return M
