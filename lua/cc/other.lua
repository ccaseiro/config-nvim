vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    -- command = "lua vim.lsp.buf.format()",
    callback = function()
        if require("cc.util").autoformat then
            -- require("conform").format({ bufnr = args.buf })
            require("conform").format()
            -- vim.lsp.buf.format()
        end
    end,
})
-- vim.api.nvim_create_autocmd({"BufWritePre"}, {pattern = "*.rs", command = "lua vim.lsp.buf.format()", })
-- vim.api.nvim_create_autocmd("BufWritePre", { pattern="*.rs", callback = function() vim.lsp.buf.format() end })

local cmp = require("cmp")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            local col = vim.fn.col(".") - 1

            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                fallback()
            else
                cmp.complete()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),

    sources = {
        { name = "copilot" },
        { name = "luasnip" },
        { name = "path" }, -- add "keyword_length = 2" to set numbers of chars to begin query
        { name = "nvim_lsp" },
        { name = "buffer" },
    },

    completion = { completeopt = "menu,menuone,noinsert", keyword_length = 1 },

    formatting = {
        fields = { "menu", "abbr", "kind" },
        format = require("lspkind").cmp_format({
            mode = "symbol",
            max_width = 50,
            symbol_map = {
                Copilot = "",
            },
        }),
        -- format = function(entry, item)
        --     local menu_icon = {
        --         nvim_lsp = "λ",
        --         -- luasnip = '⋗',
        --         buffer = "Ω",
        --         path = "🖫",
        --         cmdline = "⋗",
        --     }
        --
        --     item.menu = menu_icon[entry.source.name]
        --     return item
        -- end,
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        -- { name = "path", max_item_count = 5 },
        { name = "path" },
        { name = "cmdline" },
    }),
})

-- lsp_document_symbols
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        -- { name = "nvim_lsp_document_symbol", max_item_count = 8, keyword_length = 3 },
        { name = "buffer" },
        -- { name = "orgmode" },
    }),
})

-- local readline = require("readline")
-- vim.keymap.set("!", "<M-f>", readline.forward_word)
-- vim.keymap.set("!", "<M-b>", readline.backward_word)
-- vim.keymap.set("!", "<C-a>", readline.dwim_beginning_of_line)
-- vim.keymap.set("!", "<C-e>", readline.end_of_line)
-- vim.keymap.set("!", "<M-d>", readline.kill_word)
-- vim.keymap.set("!", "<M-BS>", readline.backward_kill_word)
-- -- vim.keymap.set('!', '<C-w>', readline.unix_word_rubout)
-- -- vim.keymap.set('!', '<C-k>', readline.kill_line)
-- vim.keymap.set("!", "<C-u>", readline.dwim_backward_kill_line)

-- highlight yank

local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 100,
        })
    end,
})

-- git
-- local neogit = require("neogit")
-- neogit.setup({
--     disable_commit_confirmation = true,
--     -- use_magit_keybindings = true
-- })

-- vim.api.nvim_create_autocmd('BufRead', {
--    callback = function()
--       vim.api.nvim_create_autocmd('BufWinEnter', {
--          once = true,
--          command = 'normal! zx zi'
--       })
--    end
-- })

-- require("treesitter-context").setup({})

-- fold: ufo
-- require("ufo").setup({})
