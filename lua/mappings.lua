require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Toggle LSP Inlay Hints
vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

vim.keymap.del("n", "<Tab>")
vim.keymap.del("n", "<S-Tab>")

-- add yours here
local opts = { noremap = true, silent = true }
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>", opts)
map("i", "jk", "<ESC>", opts)

-- Panes resizing
map("n", "+", ":resize +5<CR>", opts)
map("n", "_", ":resize -5<CR>", opts)
map("n", "=", ":vertical resize +5<CR>", opts)
map("n", "-", ":vertical resize -5<CR>", opts)
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)
map("n", "*", "*zz", opts)
-- Move selected line / block of text in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move to start/end of line
map({ "n", "x", "o" }, "H", "^", opts)
map({ "n", "x", "o" }, "L", "g_", opts)

-- telescope
-- map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map(
  "n",
  "<leader>fp",
  "<cmd>Telescope lsp_document_symbols<CR>",
  { desc = "Find document symbols (class, function, method)" }
)
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

map("n", "<leader>th", function()
  require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

if vim.env.TMUX then
  map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", opts)
  map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", opts)
  map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", opts)
  map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", opts)
end

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local api = require "nvim-tree.api"

    -- Jangan lakukan apapun jika buffer aktif adalah NvimTree
    if vim.bo.filetype == "NvimTree" then
      return
    end

    -- Jangan lakukan apapun kalau nvim-tree tidak dibuka
    if not require("nvim-tree.view").is_visible() then
      return
    end

    -- Tutup semua folder
    api.tree.collapse_all()

    -- Buka path menuju file aktif
    api.tree.find_file { open = true, focus = false }
  end,
})
