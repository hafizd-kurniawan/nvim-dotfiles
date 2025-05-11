return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<M-t>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" }, -- Alt + t
  },
  config = function()
    require("toggleterm").setup {
      direction = "float", -- Bisa diubah ke "horizontal", "vertical", atau "tab"
      start_in_insert = true, -- Terminal langsung dalam mode insert saat dibuka
      shade_terminals = true,
      shading_factor = 2,
      persist_size = true,
      persist_mode = true, -- Mode terminal tetap setelah toggle
    }

    -- Keymap untuk berpindah antar window dari terminal mode
    local opts = { noremap = true, silent = true }

    vim.api.nvim_set_keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", opts) -- Pindah ke kiri
    vim.api.nvim_set_keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", opts) -- Pindah ke kanan
    vim.api.nvim_set_keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", opts) -- Pindah ke atas
    vim.api.nvim_set_keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", opts) -- Pindah ke bawah
    vim.api.nvim_set_keymap("t", "<C-q>", "<C-\\><C-n>", opts) -- Kembali ke normal mode
    vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", opts) -- Esc keluar terminal mode
  end,
}
