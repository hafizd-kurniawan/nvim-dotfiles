return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  cmd = { "VenvSelect" },
  dependencies = {},
  init = function()
    -- Map keybinding saat plugin dimuat
    local map = vim.keymap.set
    map("n", "<Leader>lv", "<Cmd>VenvSelect<CR>", { desc = "Select VirtualEnv" })
  end,
  opts = {},
  enabled = vim.fn.executable "fd" == 1 or vim.fn.executable "fdfind" == 1 or vim.fn.executable "fd-find" == 1,
}
