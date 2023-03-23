local ls = require "luasnip"
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

-- fmt(<fmt_string>, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt

-- rep(<position>)
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {}

-- local lld= s("lld", fmt("console.log(`{}`)", {i(1)}))
local llt= s("llt", fmt("logger.trace(`{}`)", {i(1)}))
local lld= s("lld", fmt("logger.debug(`{}`)", {i(1)}))
local lli= s("lli", fmt("logger.info(`{}`)", {i(1)}))
local llw= s("llw", fmt("logger.warn(`{}`)", {i(1)}))
local lle= s("lle", fmt("logger.error(`{}`)", {i(1)}))
local llf= s("llf", fmt("logger.fatal(`{}`)", {i(1)}))
local llv= s("llv", fmt("console.log(`{}`)", {i(1)}))
-- local llv= s("llv", fmt("console.log(`{}: ${{{}}}`)", {i(1), rep(1)}))
-- local lli= s("lli", fmt("console.log(`{}: ${{inspect({})}}`)", {i(1), rep(1)}))

local cl = s("cl", fmt("console.log(`{}`)", {i(1)}))
-- local cl = s("cl", fmt("console.log(`{}: ${{{}}}`)", {i(1), rep(1)}))

table.insert(snippets, llt)
table.insert(snippets, lld)
table.insert(snippets, lli)
table.insert(snippets, llw)
table.insert(snippets, lle)
table.insert(snippets, llf)
table.insert(snippets, llv)
table.insert(snippets, cl)

return snippets, autosnippets


