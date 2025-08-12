if true then
  return {}
end
local ELLIPSIS_CHAR = "…"
local MAX_LABEL_WIDTH = 30
local MAX_PATH_WIDTH = 40

local function limitStringLength(str, maxLength)
  local truncated_label = vim.fn.strcharpart(str, 0, maxLength)
  if truncated_label ~= str then
    return truncated_label .. ELLIPSIS_CHAR
  end
  return str
end

local cmp = require("cmp")
return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local border_opts = {
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      -- col_offset = -1,
      side_padding = 2,
      scrollbar = false,
    }
    opts.formatting = {
      fields = { "abbr", "kind", "menu" },
      format = function(entry, item)
        -- icons
        local icons = require("lazyvim.config").icons.kinds
        local kind = item.kind
        if icons[item.kind] then
          item.kind = icons[item.kind]
        end
        -- import path
        if
          entry.completion_item.labelDetails ~= nil
          and entry.completion_item.labelDetails.description ~= nil
          and entry.completion_item.labelDetails.description ~= ""
        then
          -- item.menu = limitStringLength(entry.completion_item.detail, 20)
          item.menu = limitStringLength(entry.completion_item.labelDetails.description, MAX_PATH_WIDTH)
        -- else
        --   item.menu = kind
        else
          item.menu = ({
            nvim_lsp = kind,
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
        end
        -- label maxLength
        item.abbr = limitStringLength(item.abbr, MAX_LABEL_WIDTH)
        return item
      end,
    }
    opts.window = {
      -- completion = border_opts,
      -- documentation = border_opts,
      completion = cmp.config.window.bordered(border_opts),
      documentation = cmp.config.window.bordered(border_opts),
    }

    -- Customization for Pmenu
    -- vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })
    -- vim.api.nvim_set_hl(0, "Mine", { fg = "#000000", bg = "#000000" })
  end,
}
