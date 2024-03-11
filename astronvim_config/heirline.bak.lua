local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local colors = {
  bg = '#202328',
  fg = '#bbc2cf',
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67',
}

local hl = {
  Git = {
    branch = { fg = colors.violet, bold = true },
    dirty = { fg = colors.orange, bold = true },
  },
  Diagnostic = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.blue },
    hint = { fg = colors.cyan },
  },
  -- Add more highlight groups as needed
}

local FileName = {
  provider = function()
    local filename = vim.fn.expand("%:t")
    local extension = vim.fn.expand("%:e")
    local icon = require("nvim-web-devicons").get_icon(filename, extension)
    if icon then
      filename = icon .. " " .. filename
    end
    return filename
  end,
  hl = { fg = "fg", bold = true },
}

local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  hl = { fg = "fg", bg = "bg" },
  FileName,
}

local VimMode = {
  init = function(self)
    local mode_map = {
      ["n"] = { "NORMAL", "normal" },
      ["no"] = { "OP", "normal" },
      ["nov"] = { "OP", "normal" },
      ["noV"] = { "OP", "normal" },
      ["no\22"] = { "OP", "normal" },
      ["niI"] = { "NORMAL", "normal" },
      ["niR"] = { "NORMAL", "normal" },
      ["niV"] = { "NORMAL", "normal" },
      ["i"] = { "INSERT", "insert" },
      ["ic"] = { "INSERT", "insert" },
      ["ix"] = { "INSERT", "insert" },
      ["s"] = { "SELECT", "select" },
      ["S"] = { "SELECT", "select" },
      ["\19"] = { "SELECT", "select" },
      ["v"] = { "VISUAL", "visual" },
      ["V"] = { "VISUAL LINE", "visual" },
      ["\22"] = { "VISUAL BLOCK", "visual" },
      ["c"] = { "COMMAND", "command" },
      ["cv"] = { "COMMAND", "command" },
      ["ce"] = { "COMMAND", "command" },
      ["r"] = { "REPLACE", "replace" },
      ["rm"] = { "MORE", "replace" },
      ["r?"] = { "CONFIRM", "replace" },
      ["!"] = { "SHELL", "terminal" },
      ["t"] = { "TERMINAL", "terminal" },
    }
    local mode = vim.api.nvim_get_mode().mode
    self.mode = mode_map[mode][1] or "NORMAL"
    self.mode_color = mode_map[mode][2] or "normal"
  end,
  hl = function(self)
    return { fg = "bg", bg = self.mode_color, bold = true }
  end,
  {
    provider = function(self)
      return "  " .. self.mode .. " "
    end,
    hl = { fg = "bg", bold = true },
  },
  update = { "ModeChanged" },
}

local Git
do
   local GitBranch = {
      condition = conditions.is_git_repo,
      init = function(self)
         self.git_status = vim.b.gitsigns_status_dict
      end,
      hl = hl.Git.branch,
      provider = function(self)
         return table.concat{ ' ', self.git_status.head }
      end,
   }

   local GitChanges = {
      condition = function(self)
         if conditions.is_git_repo() then
            self.git_status = vim.b.gitsigns_status_dict
            local has_changes = self.git_status.added   ~= 0 or
                                self.git_status.removed ~= 0 or
                                self.git_status.changed ~= 0
            return has_changes
         end
      end,
      provider = '  ',
      hl = hl.Git.dirty
   }

   Git = { GitBranch, GitChanges, Space }
end

local function Space(n)
  return {
    provider = string.rep(' ', n),
    hl = { bg = 'NONE' },
  }
end


local Diagnostics = {
   condition = conditions.has_diagnostics,
   static = {
      error_icon = vim.fn.sign_getdefined('DiagnosticSignError')[1].text,
      warn_icon  = vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text,
      info_icon  = vim.fn.sign_getdefined('DiagnosticSignInfo')[1].text,
      hint_icon  = vim.fn.sign_getdefined('DiagnosticSignHint')[1].text,
   },
   init = function(self)
      self.errors   = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      self.hints    = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      self.info     = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
   end,
   {
      provider = function(self)
         if self.errors > 0 then
            return table.concat{ self.error_icon, self.errors, ' ' }
         end
      end,
      hl = hl.Diagnostic.error
   },
   {
      provider = function(self)
         if self.warnings > 0 then
            return table.concat{ self.warn_icon, self.warnings, ' ' }
         end
      end,
      hl = hl.Diagnostic.warn
   },
   {
      provider = function(self)
         if self.info > 0 then
            return table.concat{ self.info_icon, self.info, ' ' }
         end
      end,
      hl = hl.Diagnostic.info
   },
   {
      provider = function(self)
         if self.hints > 0 then
            return table.concat{ self.hint_icon, self.hints, ' ' }
         end
      end,
      hl = hl.Diagnostic.hint
   },
   Space(2)
}

require('heirline').setup({
  statusline = {
    VimMode, FileNameBlock, Git, Diagnostics, Space
  },
})
