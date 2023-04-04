local ls = require("luasnip")
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node
local fmt = require("luasnip.extras.fmt").fmt

local assf = s("assf", { t("assert False") })
local lld = s("lld", fmt('logger.debug(f"{}")', { i(1, "") }))
local llt = s("llt", fmt('logger.debug(f"{}")', { i(1, "") }))

local snippets, autosnippets = {}, {}
table.insert(autosnippets, assf)
table.insert(autosnippets, lld)
table.insert(autosnippets, llt)
return snippets, autosnippets
