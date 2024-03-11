local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local ViMode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  static = {
    mode_names = {
      n = "Normal",
      i = "Insert",
      v = "Visual",
      V = "V-Line",
      ["\22"] = "V-Block",
      c = "Command",
      s = "Select",
      S = "S-Line",
      ["\19"] = "S-Block",
      R = "Replace",
      r = "Replace",
      ["!"] = "Shell",
      t = "Terminal",
    },
  },
  provider = function(self)
    return "  " .. self.mode_names[self.mode] .. " "
  end,
  hl = function(self)
    -- return { fg = self.mode_color, bold = true }
    return { fg = "green", bold = true }
  end,
}

local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  -- hl = { fg = "fg", bg = "bg" },
  hl = { fg = "yellow", bg = "bg" },
  {
    provider = function(self)
      return " " .. vim.fn.fnamemodify(self.filename, ":t") .. " "
    end,
    -- hl = { fg = "fg", bold = true },
    hl = { fg = "yellow", bold = true },
  },
}

require('heirline').setup({
  statusline = {
    ViMode, FileNameBlock,
  },
})
