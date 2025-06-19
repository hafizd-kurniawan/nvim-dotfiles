-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
  integrations = {
    "notify",
    "cmp",
    "lsp",
    "treesitter",
    "telescope",
  },
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    lazyload = false,
    enabled = false,
  },

  cmp = {
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      tailwind = true,
    },
  },
  telescope = { style = "bordered" },

  statusline = {
    theme = "default",
    separator_style = "default",
    order = { "mode", "filepath", "git", "%=", "lsp_msg", "%=", "lsp", "cwd" },
    modules = {
      filepath = function()
        local path = vim.fn.expand "%:." -- relatif terhadap cwd
        return "%#St_blue#" .. path
      end,
    },
  },
}

return M
