-- change line 1828
-- in /usr/share/nvim/runtime/lua/vim/lsp/util.lua
local ok, col = pcall(M._str_byteindex_enc, line, pos.character, offset_encoding)
if ok then
  table.insert(items, {
    filename = filename,
    lnum = row + 1,
    col = col + 1,
    text = line,
  })
end
