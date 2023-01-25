telescope = require('telescope')
telescope.setup {
    defaults = {
        file_ignore_patterns = {"node_modules"},
        -- mappings = {
        --     i = {
        --         -- map actions.which_key to <C-h> (default: <C-/>)
        --         -- actions.which_key shows the mappings for your picker,
        --         -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        --         ["<C-h>"] = "which_key"
        --     }
        -- }
    }
}

-- telescope.load_extension('fzf')
telescope.load_extension('zf-native')
telescope.load_extension('file_browser')
telescope.load_extension('project')
