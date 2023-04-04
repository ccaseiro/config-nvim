telescope = require("telescope")
local fb_actions = require("telescope").extensions.file_browser.actions

telescope.load_extension("file_browser")
telescope.setup({
    defaults = {
        file_ignore_patterns = { "node_modules" },
        -- mappings = {
        --     i = {
        --         -- map actions.which_key to <C-h> (default: <C-/>)
        --         -- actions.which_key shows the mappings for your picker,
        --         -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        --         ["<C-h>"] = "which_key"
        --     }
        -- }
    },
    extensions = {
        file_browser = {
            mappings = {
                ["i"] = {
                    -- ["<C-c>"] = fb_actions.create,
                    ["<C-x>"] = fb_actions.create,
                    ["<C-d>"] = fb_actions.remove,
                },
            },
        },
    },
})

-- telescope.load_extension('fzf')
telescope.load_extension("zf-native")
telescope.load_extension("file_browser")
telescope.load_extension("project")
telescope.load_extension("attempt")
telescope.load_extension("ui-select")
