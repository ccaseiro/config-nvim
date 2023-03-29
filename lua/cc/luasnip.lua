local ls = require "luasnip"
local types = require("luasnip.util.types")

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

ls.config.set_config({
	history = true, --keep around last snippet local to jump back
	updateevents = "TextChanged,TextChangedI", --update changes as you type
	enable_autosnippets = true,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "●", "GruvboxOrange" } },
			},
		},
		-- [types.insertNode] = {
		-- 	active = {
		-- 		virt_text = { { "●", "GruvboxBlue" } },
		-- 	},
		-- },
	},
}) --}}}



vim.keymap.set({ "i", "s"}, "<c-j>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end)
vim.keymap.set({ "i", "s"}, "<A-j>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end)


vim.keymap.set({ "i", "s"}, "<c-k>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end)
vim.keymap.set({ "i", "s"}, "<A-k>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end)


vim.keymap.set({ "i", "s"}, "<c-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)
vim.keymap.set({ "i", "s"}, "<A-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)


vim.keymap.set({ "i", "s"}, "<c-h>", function()
    if ls.choice_active() then
        ls.change_choice(-1)
    end
end)
vim.keymap.set({ "i", "s"}, "<A-h>", function()
    if ls.choice_active() then
        ls.change_choice(-1)
    end
end)


