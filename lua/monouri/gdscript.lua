-- Vim indent file
-- Language: gdscript (Godot game engine)
-- Converted to Lua by Nouri Mohamed <mohamed.nouri.1997@gmail.com>
-- Based on vimscript config by: Maxim Kim <habamax@gmail.com>

local M = {}

function M.get_indent(lnum)
  local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
  local prev_lnum = vim.fn.prevnonblank(lnum - 1)

  if prev_lnum == 0 then
    -- This is the first non-empty line, use zero indent
    return 0
  end

  local prev_line = vim.api.nvim_buf_get_lines(0, prev_lnum - 1, prev_lnum, false)[1]
  local prev_indent = vim.fn.indent(prev_lnum)
  local shiftwidth = vim.fn.shiftwidth()

  -- If this line is explicitly joined: If the previous line was also joined,
  -- line it up with that one, otherwise add two 'shiftwidth'
  if prev_line:match("\\$") then
    if prev_lnum > 1 and vim.api.nvim_buf_get_lines(0, prev_lnum - 2, prev_lnum - 1, false)[1]:match("\\$") then
      return prev_indent
    end
    return prev_indent + (shiftwidth * 2)
  end

  -- If the start of the line is in a string don't change the indent
  local synname = vim.fn.synIDattr(vim.fn.synID(lnum, 1, 1), "name")
  if synname:match("String$") then
    return -1
  end

  -- Get the line and remove a trailing comment using syntax highlighting
  local pline = prev_line
  local pline_len = #pline

  if pline_len > 0 then
    -- Check if the last character is in a comment
    local last_col_synname = vim.fn.synIDattr(vim.fn.synID(prev_lnum, pline_len, 1), "name")
    if last_col_synname:match("\\(Comment\\|Todo\\)$") then
      -- Binary search for start of comment
      local min, max = 1, pline_len
      while min < max do
        local col = math.floor((min + max) / 2)
        local col_synname = vim.fn.synIDattr(vim.fn.synID(prev_lnum, col, 1), "name")
        if col_synname:match("\\(Comment\\|Todo\\)$") then
          max = col
        else
          min = col + 1
        end
      end
      pline = pline:sub(1, min - 1)
    end
  end

  -- When inside parenthesis: If at the first line below the parenthesis add
  -- one 'shiftwidth'
  if pline:match("[({}%[]%s*$") then
    return prev_indent + shiftwidth
  end

  -- If the previous line ended with a colon, indent this line
  if pline:match(":%s*$") then
    return prev_indent + shiftwidth
  end

  -- If the previous line was a stop-execution statement
  if prev_line:match("^%s*%(break%|continue%|raise%|return%|pass%)%>") then
    -- See if the user has already dedented
    if vim.fn.indent(lnum) > prev_indent - shiftwidth then
      -- If not, recommend one dedent
      return prev_indent - shiftwidth
    end
    -- Otherwise, trust the user
    return -1
  end

  -- If the current line begins with a keyword that lines up with "try"
  if line:match("^%s*%(except%|finally%)%>") then
    local try_lnum = lnum - 1
    while try_lnum >= 1 do
      local try_line = vim.api.nvim_buf_get_lines(0, try_lnum - 1, try_lnum, false)[1]
      if try_line:match("^%s*%(try%|except%)%>") then
        local ind = vim.fn.indent(try_lnum)
        if ind >= vim.fn.indent(lnum) then
          return -1 -- indent is already less than this
        end
        return ind -- line up with previous try or except
      end
      try_lnum = try_lnum - 1
    end
    return -1 -- no matching "try"!
  end

  -- If the current line begins with a header keyword, dedent
  if line:match("^%s*%(elif%|else%)%>") then
    -- Unless the previous line was a one-liner
    if prev_line:match("^%s*%(for%|if%|try%)%>") then
      return prev_indent
    end

    -- Or the user has already dedented
    if vim.fn.indent(lnum) <= prev_indent - shiftwidth then
      return -1
    end

    return prev_indent - shiftwidth
  end

  return -1
end

local function setup()
  -- Set up buffer-local indentation settings
  vim.bo.shiftwidth = 2 -- Set preferred indent width
  vim.bo.tabstop = 2
  vim.bo.expandtab = true
  vim.bo.indentexpr = ':lua require("monouri.gdscript").get_indent(v:lnum)'
  vim.bo.indentkeys = vim.bo.indentkeys .. ",<:>,=elif,=except"
end

M.setup = setup

return M
