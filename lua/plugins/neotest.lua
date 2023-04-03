return {
    {
        "nvim-neotest/neotest",
        -- tag = "v2.2.0",
        keys = {
            { "<leader>mta", "<cmd>lua require('neotest').run.attach()<cr>", desc = "attach to nearest test" },
            {
                "<leader>mtd",
                "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
                desc = "debug nearest test",
            },
            { "<leader>mtf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "run current file" },
            { "<leader>mto", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "toggle output" },
            { "<leader>mtO", "<cmd>lua require('neotest').output_panel.toggle()<cr>", desc = "toggle output panel" },
            { "<leader>mts", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "toggle summary" },
            { "<leader>mtS", "<cmd>lua require('neotest').run.stop()<cr>", desc = "stop nearest test" },
            { "<leader>mtt", "<cmd>lua require('neotest').run.run()<cr>", desc = "run nearest test" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",

            "rouge8/neotest-rust",
            "haydenmeade/neotest-jest",
            "nvim-neotest/neotest-python",
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-rust"),
                    require("neotest-jest"),
                    require("neotest-python")({
                        runner = "pytest",
                        python = ".venv/bin/python",
                        -- is_test_file = function(file_path)
                        --     return true
                        -- end,
                        -- log_level = vim.log.levels.INFO,
                    }),
                },
            })
        end,
    },
}
