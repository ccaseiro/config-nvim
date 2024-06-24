_G.LazyVim = {}
local M = {}
LazyVim.config = M

LazyVim.telescope = {}
function LazyVim.telescope.config_files()
    return function()
        require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
    end
end

-- function M.config_files()
--   return LazyVim.telescope("find_files", { cwd = vim.fn.stdpath("config") })
-- end

-- { "<leader>fc", LazyVim.telescope.config_files(), desc = "Find Config File" },
