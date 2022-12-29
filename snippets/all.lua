local ls = require "luasnip"
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

-- fmt(<fmt_string>, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt

-- rep(<position>)
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {}

local myFirstSnippet = s("xxx", { t("New xHi again! This is my first snippet in Luasnip")})
local expand = s("expand", { t("-- this is what was expanded!")})
local req = s("req", fmt("local {} = require('{}')", {i(1, "default"), rep(1)}))


table.insert(snippets, myFirstSnippet)
table.insert(snippets, expand)
table.insert(snippets, ll)
table.insert(snippets, req)

return snippets, autosnippets
