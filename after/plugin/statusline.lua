-- just for debug/experiment purposes: show info after click on statusline "filename"
function _G.ClickMe(minwid, clicks, button, mods)
  print(minwid, clicks, button, mods)
end

local function status_line()
  local mode = "%-5{%v:lua.string.upper(v:lua.vim.fn.mode())%}"
  local file_name = "%@v:lua.ClickMe@%-.16t%T"
  local buf_nr = "[%n]"
  local modified = " %-m"
  local file_type = " %y"
  local right_align = "%="
  local line_no = "%10([%l/%L%)]"
  local pct_thru_file = "%5p%%"

  return string.format(
    "%s%s%s%s%s%s%s%s",
    mode,
    file_name,
    buf_nr,
    modified,
    file_type,
    right_align,
    line_no,
    pct_thru_file
  )
end

-- vim.opt.statusline = status_line()
-- vim.opt.winbar = status_line()
vim.opt.statusline = status_line()
