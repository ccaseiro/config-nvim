local ls = require "luasnip"
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

-- fmt(<fmt_string>, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt

-- rep(<position>)
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {}

local lld= s("lld", fmt("console.log(`{}`)", {i(1)}))
local llv= s("llv", fmt("console.log(`{}: ${{{}}}`)", {i(1), rep(1)}))
local lli= s("lli", fmt("console.log(`{}: ${{inspect({})}}`)", {i(1), rep(1)}))

table.insert(snippets, lld)
table.insert(snippets, llv)
table.insert(snippets, lli)

return snippets, autosnippets

