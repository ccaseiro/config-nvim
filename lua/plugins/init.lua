return {
    "tpope/vim-unimpaired",
    "tpope/vim-abolish",
    -- makes some plugins dot-repeatable like leap
    { "tpope/vim-repeat", event = "VeryLazy" },

    -- surround
    {
        "echasnovski/mini.surround",
        keys = function(_, keys)
            -- Populate the keys based on the user's options
            local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
            local opts = require("lazy.core.plugin").values(plugin, "opts", false)
            local mappings = {
                { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
                { opts.mappings.delete, desc = "Delete surrounding" },
                { opts.mappings.find, desc = "Find right surrounding" },
                { opts.mappings.find_left, desc = "Find left surrounding" },
                { opts.mappings.highlight, desc = "Highlight surrounding" },
                { opts.mappings.replace, desc = "Replace surrounding" },
                { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
            }
            mappings = vim.tbl_filter(function(m)
                return m[1] and #m[1] > 0
            end, mappings)
            return vim.list_extend(mappings, keys)
        end,
        opts = {
            mappings = {
                add = "gza", -- Add surrounding in Normal and Visual modes
                delete = "gzd", -- Delete surrounding
                find = "gzf", -- Find surrounding (to the right)
                find_left = "gzF", -- Find surrounding (to the left)
                highlight = "gzh", -- Highlight surrounding
                replace = "gzr", -- Replace surrounding
                update_n_lines = "gzn", -- Update `n_lines`
            },
        },
        config = function(_, opts)
            -- use gz mappings instead of s to prevent conflict with leap
            require("mini.surround").setup(opts)
        end,
    },
    {
        "echasnovski/mini.bufremove",
        -- stylua: ignore
        keys = {
            { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
            { "<leader>bk", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
            { "<leader>bK", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
        },
    },
    -- {
    --     "ggandor/leap.nvim",
    --     dependencies = "tpope/vim-repeat",
    --     keys = {
    --         { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
    --         { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
    --         { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    --     },
    --     config = function(_, opts)
    --         local leap = require("leap")
    --         for k, v in pairs(opts) do
    --             leap.opts[k] = v
    --         end
    --         leap.add_default_mappings(true)
    --         vim.keymap.del({ "x", "o" }, "x")
    --         vim.keymap.del({ "x", "o" }, "X")
    --     end,
    -- },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    -- default options: exact mode, multi window, all directions, with a backdrop
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    -- show labeled treesitter nodes around the cursor
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    -- jump to a remote location to execute the operator
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    -- show labeled treesitter nodes around the search matches
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search",
            },
        },
    },

    -- Colorschemes

    {
        "nvim-lualine/lualine.nvim",
        -- requires = {"kyazdani42/nvim-web-devicons", opt = true},
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup()
        end,
    },

    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup()
        end,
    },
    -- TODO: remove?
    { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },

    {
        "m-demare/attempt.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/playground",
        },
        config = function()
            require("attempt").setup()
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("cc.luasnip")
        end,
    },

    "onsails/lspkind.nvim",

    -- cmp
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "saadparwaiz1/cmp_luasnip",
    -- editing
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },

    -- "linty-org/readline.nvim",

    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("cc/toggleterm")
        end,
    },

    -- session management
    -- {
    --     "folke/persistence.nvim",
    --     event = "BufReadPre",
    --     opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
    --     -- stylua: ignore
    --     keys = {
    --         { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
    --         { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    --         { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    --     },
    -- },
    {
        "echasnovski/mini.sessions",
        lazy = false,
        version = false,
        keys = {
            {
                "<leader>qs",
                function()
                    MiniSessions.select()
                end,
                desc = "Restore Session",
            },
            {
                "<leader>ql",
                function()
                    MiniSessions.read()
                end,
                desc = "Restore Last Session",
            },
            {
                "<leader>qw",
                function()
                    local project_actions = require("telescope._extensions.project.actions")
                    local project_name = project_actions.get_selected_title()
                    vim.ui.input({ prompt = "Name: ", default = project_name }, function(name)
                        MiniSessions.write(name)
                    end)
                end,
                desc = "Write Session",
            },
            {
                "<leader>qd",
                function()
                    -- local project_actions = require("telescope._extensions.project.actions")
                    -- local project_name = project_actions.get_selected_title()
                    local session_name = MiniSessions.select("delete")
                    -- vim.ui.input({ prompt = "Name: ", default = session_name }, function(name)
                    --     MiniSessions.delete(name)
                    -- end)
                end,
                desc = "Delete Session",
            },
        },
        config = function()
            require("mini.sessions").setup()
        end,
    },

    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        lazy = false,
        keys = {
            {
                "<leader>np",
                "<cmd>MarkdownPreviewToggle<cr>",
                desc = "markdown preview",
            },
        },
    },

    {
        "MaximilianLloyd/lazy-reload.nvim",
        opts = {
            command_name = "ReloadPlugin",
        },
        keys = {
            -- Opens the command.
            { "<leader>hrp", "<cmd>lua require('lazy-reload').feed()<cr>", desc = "Reload a plugin" },
        },
    },

    {
        "mbbill/undotree",
        lazy = false,
        keys = {
            { "<leader>tu", "<cmd>UndotreeToggle | UndotreeFocus<cr>", desc = "Toggle Undotree" },
        },
    },
    {
        "andymass/vim-matchup",
        setup = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            {
                "<leader><cr>",
                "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
                desc = "view all project marks",
            },
            {
                "<leader>ml",
                "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
                desc = "view all project marks",
            },
            {
                "<leader>ma",
                "<cmd>lua require('harpoon.mark').add_file()<cr>",
                desc = "mark files",
            },
            {
                "<leader>mm",
                "<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
                desc = "navigates to file 1",
            },
            {
                "<leader>mn",
                "<cmd>lua require('harpoon.ui').nav_file(2)<cr>",
                desc = "navigates to file 2",
            },
            {
                "<leader>me",
                "<cmd>lua require('harpoon.ui').nav_file(3)<cr>",
                desc = "navigates to file 3",
            },
            {
                "<leader>mi",
                "<cmd>lua require('harpoon.ui').nav_file(4)<cr>",
                desc = "navigates to file 4",
            },
            {
                "<leader>mo",
                "<cmd>lua require('harpoon.ui').nav_file(5)<cr>",
                desc = "navigates to file 5",
            },
            {
                "<leader>mj",
                "<cmd>lua require('harpoon.ui').nav_next()<cr>",
                desc = "navigates to next mark",
            },
            {
                "<leader>mk",
                "<cmd>lua require('harpoon.ui').nav_next()<cr>",
                desc = "navigates to prev mark",
            },
            {
                "<leader>mq",
                "<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>",
                desc = "navigates to term 1",
            },
            {
                "<leader>mw",
                "<cmd>lua require('harpoon.term').gotoTerminal(2)<cr>",
                desc = "navigates to term 2",
            },
            {
                "<leader>mf",
                "<cmd>lua require('harpoon.term').gotoTerminal(3)<cr>",
                desc = "navigates to term 3",
            },
            {
                "<leader>mp",
                "<cmd>lua require('harpoon.term').gotoTerminal(4)<cr>",
                desc = "navigates to term 4",
            },
            {
                "<leader>mb",
                "<cmd>lua require('harpoon.term').gotoTerminal(5)<cr>",
                desc = "navigates to term 5",
            },
        },
        config = function()
            require("telescope").load_extension("harpoon")
        end,
    },
    {
        "willothy/flatten.nvim",
        config = true,
        -- or pass configuration with
        -- opts = {  }
        -- Ensure that it runs first to minimize delay when opening file from terminal
        lazy = false,
        priority = 1001,
    },
    {
        "chentoast/marks.nvim",
        config = function()
            require("marks").setup({
                bookmark_0 = {
                    sign = "⚑",
                },
            })
        end,
    },
    {
        "nvim-orgmode/orgmode",
        event = "VeryLazy",
        ft = { "org" },
        config = function()
            -- Setup orgmode
            require("orgmode").setup({
                org_agenda_files = "~/orgfiles/**/*",
                org_default_notes_file = "~/orgfiles/refile.org",
            })

            -- NOTE: If you are using nvim-treesitter with `ensure_installed = "all"` option
            -- add `org` to ignore_install
            -- require('nvim-treesitter.configs').setup({
            --   ensure_installed = 'all',
            --   ignore_install = { 'org' },
            -- })
        end,
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    -- {
    --     "m4xshen/hardtime.nvim",
    --     dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    --     opts = {
    --         max_count = 10,
    --         disable_mouse = false,
    --         disabled_keys = {
    --             ["<Up>"] = {},
    --             ["<Down>"] = {},
    --             ["<Left>"] = {},
    --             ["<Right>"] = {},
    --         },
    --     },
    -- },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
    -- {
    --     "nvim-cmp",
    --     dependencies = {
    --         {
    --             "zbirenbaum/copilot-cmp",
    --             dependencies = "copilot.lua",
    --             opts = {},
    --             config = function(_, opts)
    --                 local copilot_cmp = require("copilot_cmp")
    --                 copilot_cmp.setup(opts)
    --                 -- attach cmp source whenever copilot attaches
    --                 -- fixes lazy-loading issues with the copilot cmp source
    --                 require("lazyvim.util").lsp.on_attach(function(client)
    --                     if client.name == "copilot" then
    --                         copilot_cmp._on_insert_enter({})
    --                     end
    --                 end)
    --             end,
    --         },
    --     },
    --     ---@param opts cmp.ConfigSchema
    --     opts = function(_, opts)
    --         table.insert(opts.sources, 1, {
    --             name = "copilot",
    --             group_index = 1,
    --             priority = 100,
    --         })
    --     end,
    -- },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        opts = {},
        config = function(_, opts)
            local copilot_cmp = require("copilot_cmp")
            copilot_cmp.setup(opts)
            -- attach cmp source whenever copilot attaches
            -- fixes lazy-loading issues with the copilot cmp source
            -- require("lazyvim.util").lsp.on_attach(function(client)
            --     if client.name == "copilot" then
            --         copilot_cmp._on_insert_enter({})
            --     end
            -- end)
        end,
    },
    {
        "stevearc/conform.nvim",
        dependencies = { "mason.nvim" },
        lazy = true,
        cmd = "ConformInfo",

        opts = {
            format_on_save = {
                -- I recommend these options. See :help conform.format for details.
                lsp_fallback = true,
                timeout_ms = 500,
            },
            -- -- If this is set, Conform will run the formatter asynchronously after save.
            -- -- It will pass the table to conform.format().
            -- -- This can also be a function that returns the table.
            -- format_after_save = {
            --     lsp_fallback = true,
            -- },

            formatters_by_ft = {
                python = { "black" },
                lua = { "stylua" },
                fish = { "fish_indent" },
                terraform = { "terraform_fmt" },
                sh = { "shfmt" },
            },
        },
    },
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
        cmd = "VenvSelect",
        opts = {
            -- Your options go here
            name = { ".venv", ".venv-prod", ".venv-pipeline" },
            -- auto_refresh = false
            -- parents = 2,
        },
        event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
        keys = {
            -- Keymap to open VenvSelector to pick a venv.
            { "<leader>cv", "<cmd>VenvSelect<cr>" },
            -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
            { "<leader>cc", "<cmd>VenvSelectCached<cr>" },
            { "<leader>cC", "<cmd>VenvSelectCurrent<cr>" },
        },
        config = function(_, opts)
            require("venv-selector").setup(opts)
            local augroup = vim.api.nvim_create_augroup("VenvSelectorRetrieve", { clear = true })
            vim.api.nvim_create_autocmd({ "LspAttach" }, {
                pattern = { "*.py" },
                group = augroup,
                callback = function(args)
                    if vim.lsp.get_client_by_id(args["data"]["client_id"])["name"] == "pyright" then
                        require("venv-selector").retrieve_from_cache()
                        vim.api.nvim_del_augroup_by_id(augroup)
                    end
                end,
            })
        end,
    },
    -- {
    --     "folke/trouble.nvim",
    --     dependencies = { "nvim-tree/nvim-web-devicons" },
    --     opts = {
    --         -- your configuration comes here
    --         -- or leave it empty to use the default settings
    --         -- refer to the configuration section below
    --     },
    -- },
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        event = "VeryLazy",
        opts = { use_diagnostic_signs = true, auto_open = false, auto_close = true },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
            { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
            { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
            {
                "<leader>tt",
                "<cmd>lua if require('cc.util').toggle_01() then require('trouble').setup({auto_open = true}) require('trouble').open() else require('trouble').setup({auto_open = false}) require('trouble').close() end<cr>",
                desc = "Toggle Trouble",
            },
            {
                "[q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").previous({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cprev)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Previous trouble/quickfix item",
            },
            {
                "]q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").next({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cnext)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Next trouble/quickfix item",
            },
        },
    },
    {
        "nvim-pack/nvim-spectre",
        build = false,
        cmd = "Spectre",
        opts = { open_cmd = "noswapfile vnew" },
            -- stylua: ignore
            keys = {
                { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
            },
    },
    {
        "chrisbra/Colorizer",
    },
    {
        "m00qek/baleia.nvim",
        config = function()
            vim.api.nvim_create_user_command("BaleiaColorize", function()
                local baleia = require("baleia").setup({
                    colors = {
                        [00] = "Black",
                        [01] = "DarkRed",
                        [02] = "DarkGreen",
                        [03] = "DarkYellow",
                        [04] = "DarkBlue",
                        [05] = "DarkMagenta",
                        [06] = "DarkCyan",
                        [07] = "LightGrey",
                        [08] = "DarkGrey",
                        [09] = "LightRed",
                        [10] = "LightGreen",
                        [11] = "LightYellow",
                        [12] = "LightBlue",
                        [13] = "LightMagenta",
                        [14] = "LightCyan",
                        [15] = "White",
                    },
                })
                baleia.once(vim.api.nvim_get_current_buf())
            end, { bang = true })
        end,
    },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({})
        end,
    },
}
