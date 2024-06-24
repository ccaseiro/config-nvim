return {
    {
        "nvim-neotest/neotest",
        -- tag = "v2.2.0",
        keys = {
            { "<leader>t", "", desc = "+test" },
            {
                "<leader>tt",
                function()
                    require("neotest").run.run(vim.fn.expand("%"))
                end,
                desc = "Run File",
            },
            {
                "<leader>tT",
                function()
                    require("neotest").run.run(vim.uv.cwd())
                end,
                desc = "Run All Test Files",
            },
            {
                "<leader>tr",
                function()
                    require("neotest").run.run()
                end,
                desc = "Run Nearest",
            },
            {
                "<leader>tl",
                function()
                    require("neotest").run.run_last()
                end,
                desc = "Run Last",
            },
            {
                "<leader>ts",
                function()
                    require("neotest").summary.toggle()
                end,
                desc = "Toggle Summary",
            },
            {
                "<leader>to",
                function()
                    require("neotest").output.open({ enter = true, auto_close = true })
                end,
                desc = "Show Output",
            },
            {
                "<leader>tO",
                function()
                    require("neotest").output_panel.toggle()
                end,
                desc = "Toggle Output Panel",
            },
            {
                "<leader>tS",
                function()
                    require("neotest").run.stop()
                end,
                desc = "Stop",
            },
            {
                "<leader>tw",
                function()
                    require("neotest").watch.toggle(vim.fn.expand("%"))
                end,
                desc = "Toggle Watch",
            },

            -- { "<leader>ta", "<cmd>lua require('neotest').run.attach()<cr>", desc = "attach to nearest test" },
            -- {
            --     "<leader>td",
            --     "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
            --     desc = "debug nearest test",
            -- },
            {
                "<leader>tv",
                "<cmd>lua require('neotest').run.run({ extra_args = {'-vv'}})<cr>",
                desc = "run nearest test (verbose)",
            },
        },
        dependencies = {

            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",

            "rouge8/neotest-rust",
            "haydenmeade/neotest-jest",
            "nvim-neotest/neotest-python",
        },
        opts = {
            adapters = {
                -- require("neotest-rust"),
                "neotest-rust",
                -- require("neotest-jest")({
                --     cwd = function(path)
                --         -- return vim.fn.getcwd()
                --         return "/Users/ccaseiro/Developer/Outscope/vap-api/modules/lambda/layers"
                --     end,
                -- }),
                ["neotest-jest"] = {
                    cwd = function(path)
                        -- return vim.fn.getcwd()
                        return "/Users/ccaseiro/Developer/Outscope/vap-api/modules/lambda/layers"
                    end,
                },
                ["neotest-python"] = {
                    runner = "pytest",
                    python = ".venv/bin/python",
                    cwd = function(path)
                        return "/Users/ccaseiro/Temp/vap-st-connector/lambdas/"
                    end,
                    -- is_test_file = function(file_path)
                    --     return true
                    -- end,
                    -- log_level = vim.log.levels.INFO,
                },
            },
            status = { virtual_text = true },
            output = { open_on_run = true },
            quickfix = {
                open = function()
                    -- if LazyVim.has("trouble.nvim") then
                    --     require("trouble").open({ mode = "quickfix", focus = false })
                    -- else
                    --     vim.cmd("copen")
                    -- end
                    require("trouble").open({ mode = "quickfix", focus = false })
                end,
            },
        },
        config = function(_, opts)
            -- opts.adapters = {
            --     -- require("neotest-rust"),
            --     "neotest-rust",
            --     require("neotest-jest")({
            --         cwd = function(path)
            --             -- return vim.fn.getcwd()
            --             return "/Users/ccaseiro/Developer/Outscope/vap-api/modules/lambda/layers"
            --         end,
            --     }),
            --     require("neotest-python")({
            --         runner = "pytest",
            --         python = ".venv/bin/python",
            --         cwd = function(path)
            --             return "/Users/ccaseiro/Temp/vap-st-connector/lambdas/"
            --         end,
            --         -- is_test_file = function(file_path)
            --         --     return true
            --         -- end,
            --         -- log_level = vim.log.levels.INFO,
            --     }),
            -- }
            -- require("neotest").setup({
            -- })
            -- if LazyVim.has("trouble.nvim") then
            opts.consumers = opts.consumers or {}
            -- Refresh and auto close trouble after running tests
            ---@type neotest.Consumer
            opts.consumers.trouble = function(client)
                client.listeners.results = function(adapter_id, results, partial)
                    if partial then
                        return
                    end
                    local tree = assert(client:get_position(nil, { adapter = adapter_id }))

                    local failed = 0
                    for pos_id, result in pairs(results) do
                        if result.status == "failed" and tree:get_key(pos_id) then
                            failed = failed + 1
                        end
                    end
                    vim.schedule(function()
                        local trouble = require("trouble")
                        if trouble.is_open() then
                            trouble.refresh()
                            if failed == 0 then
                                trouble.close()
                            end
                        end
                    end)
                    return {}
                end
            end
            -- end
            if opts.adapters then
                local adapters = {}
                for name, config in pairs(opts.adapters or {}) do
                    if type(name) == "number" then
                        if type(config) == "string" then
                            config = require(config)
                        end
                        adapters[#adapters + 1] = config
                    elseif config ~= false then
                        local adapter = require(name)
                        if type(config) == "table" and not vim.tbl_isempty(config) then
                            local meta = getmetatable(adapter)
                            if adapter.setup then
                                adapter.setup(config)
                            elseif meta and meta.__call then
                                adapter(config)
                            else
                                error("Adapter " .. name .. " does not support setup")
                            end
                        end
                        adapters[#adapters + 1] = adapter
                    end
                end
                opts.adapters = adapters
            end
            require("neotest").setup(opts)
        end,
    },
    {
        "mfussenegger/nvim-dap",
        -- optional = true,
        -- dependencies = {
        --     "mfussenegger/nvim-dap-python",
        --     --- stylua: ignore
        --     keys = {
        --         {
        --             "<leader>dPt",
        --             function()
        --                 require("dap-python").test_method()
        --             end,
        --             desc = "Debug Method",
        --             ft = "python",
        --         },
        --         {
        --             "<leader>dPc",
        --             function()
        --                 require("dap-python").test_class()
        --             end,
        --             desc = "Debug Class",
        --             ft = "python",
        --         },
        --     },
        --     config = function()
        --         -- if vim.fn.has("win32") == 1 then
        --         --     require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
        --         -- else
        --         --     require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"))
        --         -- end
        --     end,
        -- },

        keys = {
            {
                "<leader>td",
                function()
                    require("neotest").run.run({ strategy = "dap" })
                end,
                desc = "Debug Nearest",
            },
        },
    },
}
