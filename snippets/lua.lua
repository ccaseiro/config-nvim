local ls = require "luasnip"
local s = ls.s
local i = ls.i
local t = ls.t


local snippets, autosnippets = {}, {}

local myFirstSnippet = s("yyy", { t("Hi! This is my first snippet in Luasnip")})
table.insert(snippets, myFirstSnippet)

return snippets, autosnippets
