return {
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        cmd = {
            "ObsidianOpen",
            "ObsidianNew",
            "ObsidianQuickSwitch",
            "ObsidianFollowLink",
            "ObsidianBacklinks",
            "ObsidianToday",
            "ObsidianYesterday",
            "ObsidianTemplate",
            "ObsidianSearch",
            "ObsidianLink",
            "ObsidianLinkNew",
        },

        ft = "markdown",
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        -- event = {
        --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
        --   "BufReadPre path/to/my-vault/**.md",
        --   "BufNewFile path/to/my-vault/**.md",
        -- },
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",

            -- see below for full list of optional dependencies 👇
        },
        opts = {
            workspaces = {
                {
                    name = "PKM",
                    path = "/Users/ccaseiro/Library/Mobile Documents/iCloud~md~obsidian/Documents/PKM",
                },
                -- {
                --     name = "work",
                --     path = "~/vaults/work",
                -- },
            },

            -- see below for full list of options 👇
            note_id_func = function(title)
                -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
                -- In this case a note with the title 'My new note' will be given an ID that looks
                -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
                local suffix = ""
                if title ~= nil then
                    -- If title is given, transform it into valid file name.
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    -- If title is nil, just add 4 random uppercase letters to the suffix.
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return tostring(os.time()) .. "-" .. suffix
            end,
            ui = {
                checkboxes = {
                    -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
                    [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                    ["x"] = { char = "", hl_group = "ObsidianDone" },
                    -- [">"] = { char = "", hl_group = "ObsidianRightArrow" },
                    -- ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
                    -- Replace the above with this if you don't have a patched font:
                    -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
                    -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

                    -- You can also add more custom ones...
                },
            },

            -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
            -- URL it will be ignored but you can customize this behavior here.
            ---@param url string
            follow_url_func = function(url)
                -- Open the URL in the default web browser.
                vim.fn.jobstart({ "open", url }) -- Mac OS
                -- vim.fn.jobstart({"xdg-open", url})  -- linux
            end,
        },
        init = function()
            require("which-key").register({ ["<leader>n"] = { name = "+notes" } })
        end,
        keys = {
            { "<leader>nb", "<CMD>ObsidianBacklinks<CR>", desc = "Show Backlinks" },
            { "<leader>nb", "<CMD>ObsidianBacklinks<CR>", desc = "Show Backlinks" },
            { "<leader>nc", "<CMD>ObsidianToggleCheckbox<CR>", desc = "Toggle Checkbox" },
            { "<leader>nd", "<CMD>ObsidianToday<CR>", desc = "Today" },
            { "<leader>nf", "<CMD>ObsidianQuickSwitch<CR>", desc = "Quick Switch" },
            { "<leader>ni", "<CMD>ObsidianQuickSwitch Index.md<CR>", desc = "Index" },
            { "<leader>nl", "<CMD>ObsidianLinks<CR>", desc = "Show Links" },
            { "<leader>nn", "<CMD>ObsidianNew<CR>", desc = "New Note" },
            { "<leader>no", "<CMD>ObsidianOpen<CR>", desc = "Open in Obsidian App" },
            { "<leader>ns", "<CMD>ObsidianSearch<CR>", desc = "Search Obsidian" },
        },
    },

    -- {
    --     "renerocksai/telekasten.nvim",
    --     lazy = false,
    --     dependencies = {
    --         "nvim-telescope/telescope.nvim",
    --         "renerocksai/calendar-vim",
    --     },
    --     init = function()
    --         require("which-key").register({ ["<leader>nz"] = { name = "+telekasten" } })
    --     end,
    --     keys = {
    --         { "<leader>nzz", "<CMD>ObsidianQuickSwitch<CR>", desc = "Quick Switch" },
    --         {
    --             "<leader>nzc",
    --             "<cmd>Telekasten show_calendar<cr>",
    --             desc = "show calendar",
    --         },
    --         {
    --             "<leader>nzC",
    --             "<cmd>CalendarT<cr>",
    --             desc = "calendar",
    --         },
    --         {
    --             "<leader>nzp",
    --             "<cmd>Telekasten panel<cr>",
    --             desc = "panel",
    --         },
    --         {
    --             "<leader>nzf",
    --             "<cmd>Telekasten find_notes<cr>",
    --             desc = "find notes",
    --         },
    --         {
    --             "<leader>nzg",
    --             "<cmd>Telekasten search_notes<cr>",
    --             desc = "search notes",
    --         },
    --         {
    --             "<leader>nzd",
    --             "<cmd>Telekasten goto_today<cr>",
    --             desc = "goto today",
    --         },
    --         {
    --             "<leader>nzi",
    --             "<cmd>Telekasten follow_link<cr>",
    --             desc = "follow link",
    --         },
    --         {
    --             "<leader>nzn",
    --             "<cmd>Telekasten new_note<cr>",
    --             desc = "new note",
    --         },
    --         {
    --             "<leader>nzt",
    --             "<cmd>Telekasten toggle_todo<cr>",
    --             desc = "toggle todo",
    --         },
    --         {
    --             "<leader>nzw",
    --             "<cmd>Telekasten goto_thisweek<cr>",
    --             desc = "goto this week",
    --         },
    --     },
    --     config = function()
    --         local home = vim.fn.expand("~/Documents/Notes") -- Put the name of your notes directory here
    --         require("telekasten").setup({
    --             home = home,
    --             -- dir names for special notes (absolute path or subdir name)
    --             dailies = home .. "/" .. "daily",
    --             weeklies = home .. "/" .. "weekly",
    --             templates = home .. "/" .. "templates",
    --         })
    --     end,
    -- },
}
