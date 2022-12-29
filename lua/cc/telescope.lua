telescope = require('telescope')
telescope.setup {
    defaults = {
        file_ignore_patterns = {"node_modules"}
    }
}

-- telescope.load_extension('fzf')
telescope.load_extension('zf-native')
telescope.load_extension('file_browser')
telescope.load_extension('project')
