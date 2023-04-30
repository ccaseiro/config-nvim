local ls = require("luasnip")
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node
local fmt = require("luasnip.extras.fmt").fmt

local assf = s("assf", { t("assert False") })
local llf = s("llf", fmt('logger.fatal(f"{}")', { i(1, "") }))
local lle = s("lle", fmt('logger.error(f"{}")', { i(1, "") }))
local llw = s("llw", fmt('logger.warning(f"{}")', { i(1, "") }))
local lli = s("lli", fmt('logger.info(f"{}")', { i(1, "") }))
local lld = s("lld", fmt('logger.debug(f"{}")', { i(1, "") }))
local llt = s("llt", fmt('logger.debug(f"{}")', { i(1, "") }))

local snippets, autosnippets = {}, {}
table.insert(autosnippets, assf)
table.insert(autosnippets, llf)
table.insert(autosnippets, lle)
table.insert(autosnippets, llw)
table.insert(autosnippets, lli)
table.insert(autosnippets, lld)
table.insert(autosnippets, llt)
return snippets, autosnippets
