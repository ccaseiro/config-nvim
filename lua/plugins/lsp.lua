local map = require("cc.keymap").map
local nnoremap = require("cc.keymap").nnoremap
local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.hover, bufopts)

    nnoremap("gd", "<cmd>Telescope lsp_definitions<cr>")
    map("n", "gD", "<cmd>Telescope lsp_references show_line=false<cr>", { desc = "References (no line)" })
    map("n", "gR", "<cmd>Telescope lsp_references fname_width=80<cr>", { desc = "References (width=100)" })
    map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
end
return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            local nls = require("null-ls")
            local sources = {
                nls.builtins.formatting.shfmt,
                nls.builtins.formatting.prettier,
                -- nls.builtins.diagnostics.jshint,
                nls.builtins.diagnostics.eslint_d,
                nls.builtins.formatting.stylua,
                nls.builtins.formatting.black,
            }
            nls.setup({
                sources = sources,
                on_attach = on_attach,
                debug = true,
            })
        end,
    },

    -- {
    --     "stevearc/conform.nvim",
    --     dependencies = { "mason.nvim" },
    --     lazy = true,
    --     cmd = "ConformInfo",
    --     keys = {
    --         {
    --             "<leader>cF",
    --             function()
    --                 require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
    --             end,
    --             mode = { "n", "v" },
    --             desc = "Format Injected Langs",
    --         },
    --     },
    --     init = function()
    --         -- Install the conform formatter on VeryLazy
    --         LazyVim.on_very_lazy(function()
    --             LazyVim.format.register({
    --                 name = "conform.nvim",
    --                 priority = 100,
    --                 primary = true,
    --                 format = function(buf)
    --                     local plugin = require("lazy.core.config").plugins["conform.nvim"]
    --                     local Plugin = require("lazy.core.plugin")
    --                     local opts = Plugin.values(plugin, "opts", false)
    --                     require("conform").format(LazyVim.merge({}, opts.format, { bufnr = buf }))
    --                 end,
    --                 sources = function(buf)
    --                     local ret = require("conform").list_formatters(buf)
    --                     ---@param v conform.FormatterInfo
    --                     return vim.tbl_map(function(v)
    --                         return v.name
    --                     end, ret)
    --                 end,
    --             })
    --         end)
    --     end,
    --     opts = function()
    --         local plugin = require("lazy.core.config").plugins["conform.nvim"]
    --         if plugin.config ~= M.setup then
    --             LazyVim.error({
    --                 "Don't set `plugin.config` for `conform.nvim`.\n",
    --                 "This will break **LazyVim** formatting.\n",
    --                 "Please refer to the docs at https://www.lazyvim.org/plugins/formatting",
    --             }, { title = "LazyVim" })
    --         end
    --         ---@class ConformOpts
    --         local opts = {
    --             -- LazyVim will use these options when formatting with the conform.nvim formatter
    --             format = {
    --                 timeout_ms = 3000,
    --                 async = false, -- not recommended to change
    --                 quiet = false, -- not recommended to change
    --                 lsp_fallback = true, -- not recommended to change
    --             },
    --             ---@type table<string, conform.FormatterUnit[]>
    --             formatters_by_ft = {
    --                 lua = { "stylua" },
    --                 fish = { "fish_indent" },
    --                 sh = { "shfmt" },
    --             },
    --             -- The options you set here will be merged with the builtin formatters.
    --             -- You can also define any custom formatters here.
    --             ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
    --             formatters = {
    --                 injected = { options = { ignore_errors = true } },
    --                 -- # Example of using dprint only when a dprint.json file is present
    --                 -- dprint = {
    --                 --   condition = function(ctx)
    --                 --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
    --                 --   end,
    --                 -- },
    --                 --
    --                 -- # Example of using shfmt with extra args
    --                 -- shfmt = {
    --                 --   prepend_args = { "-i", "2", "-ci" },
    --                 -- },
    --             },
    --         }
    --         return opts
    --     end,
    --     config = M.setup,
    -- }

    {
        "neovim/nvim-lspconfig",
        keys = {
            { "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
            { "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
            {
                "]e",
                "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>",
                desc = "Next Error",
            },
            {
                "[e",
                "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>",
                desc = "Prev Error",
            },
            --             nnoremap("[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>")
            -- nnoremap("]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>")
        },
        opts = {
            -- make sure mason installs the server
            servers = {
                jsonls = {
                    -- lazy-load schemastore when needed
                    on_new_config = function(new_config)
                        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
                        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
                    end,
                    settings = {
                        json = {
                            format = {
                                enable = true,
                            },
                            validate = { enable = true },
                        },
                    },
                },
            },
            setup = {},
        },
        config = function(_, opts)
            for name, icon in pairs(require("cc.config").icons.diagnostics) do
                name = "DiagnosticSign" .. name
                vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
            end

            lspconfig = require("lspconfig")

            -- local on_new_config = function(_, config)
            --     -- vim.env.VIRTUAL_ENV = "/Users/ccaseiro/Developer/Outscope/vap-st-connector/lambdas/.venv"
            --     -- vim.env.PATH = "/Users/ccaseiro/Developer/Outscope/vap-st-connector/lambdas/.venv/bin:" .. vim.env.PATH
            --     vim.env.VIRTUAL_ENV =
            --         "/Users/ccaseiro/Developer/Outscope/vap-l2c-core/functions/fetch_cache_login/.venv"
            --     vim.env.PATH =
            --         -- ".venv/bin:/opt/homebrew/bin:/Users/ccaseiro/Developer/Outscope/vap-st-connector/lambdas/.venv/bin:"
            --         -- ".venv/bin:$HOME/.pyenv/shims:" .. vim.env.PATH
            --         "$HOME/.pyenv/shims:" .. vim.env.PATH
            --     vim.env.PYTHONHOME = ""
            -- end

            lspconfig.pyright.setup({
                on_attach = on_attach,
                -- on_new_config = on_new_config,
            })
        end,
    },
}
