local ls = require("luasnip")
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

-- fmt(<fmt_string>, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt

-- rep(<position>)
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {}

-- local myFirstSnippet = s("xxx", {
--     t("Hello! This is my first snippet in Luasnip"),
--     i(1, " placeholder_text"),
--     i(2, " second"),
--     t(" this is another text node")
-- })

local expand = s("expand", { t("-- this is what was expanded!") })
local req = s("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1) }))

-- local llx= s("llx", fmt("console.log(`{}: ${{{}}}`)", {i(1), rep(1)}))
-- local llx= s("llx", fmt([[
-- console.log(`{}: ${{{}}}`)
-- ]], {
--     i(1), rep(1)
-- }))
local fmt = s(
    "fmt",
    fmt(
        [[
console.log(`{}: ${{{}}}. xxxx: {}`)
]],
        {
            i(1, "1"),
            i(2, "3"),
            c(3, { t("2"), t("this"), t("that") }),
        }
    )
)

-- table.insert(autosnippets, myFirstSnippet)
table.insert(snippets, expand)
table.insert(snippets, req)
table.insert(autosnippets, fmt)

return snippets, autosnippets
