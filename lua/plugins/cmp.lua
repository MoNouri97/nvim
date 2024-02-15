local function limitStringLength(str, maxLength)
  if string.len(str) > maxLength then
    return string.sub(str, 1, maxLength)
  else
    return str
  end
end

return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-emoji" },
  opts = function(_, opts)
    -- opts.formatting = {
    -- format = function(entry, vim_item)
    --   local kind = require("lazyvim.config").icons.kinds[vim_item.kind]
    --   local strings = vim.split(vim_item.kind, "%s", { trimempty = true })
    --   vim_item.kind = " " .. (strings[1] or "") .. " "
    --   vim_item.menu = "    (" .. (strings[2] or "") .. ")"
    --
    --   return vim_item
    -- end,
    -- }
    local cmp = require("cmp")
    opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    local border_opts = {
      -- border = "rounded",
      -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -4,
      -- side_padding = 1,
      winhighlight = "Normal:FloatBorder,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      -- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
    }
    ---@diagnostic disable-next-line: missing-fields
    opts.formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, item)
        local icons = require("lazyvim.config").icons.kinds
        local kind = item.kind
        if icons[item.kind] then
          -- item.kind = icons[item.kind] .. item.kind
          item.kind = icons[item.kind]
        end
        if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= "" then
          item.menu = limitStringLength(entry.completion_item.detail, 20)
        -- else
        --   item.menu = kind
        else
          item.menu = ({
            nvim_lsp = kind,
            -- nvim_lsp = kind .. " [LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
        end
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
    vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })
  end,
}
