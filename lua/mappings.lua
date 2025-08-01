require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
vim.keymap.del("n", "<Tab>")
vim.keymap.del("n", "<S-Tab>")

-- Toggle LSP Inlay Hints
vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

-- map("n", ";", ":", { desc = "CMD enter command mode" })
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

-- Additional useful mappings for Ubuntu BSPWM setup
-- Quick save
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<ESC>:w<CR>a", { desc = "Save file" })

-- Better scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Clear search highlighting
map("n", "<Esc>", ":noh<CR>", { desc = "Clear search highlights" })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Replace word under cursor
map("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace word under cursor" })

-- Spectre (search and replace)
map("n", "<leader>S", "<cmd>Spectre<CR>", { desc = "Open Spectre" })
map("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", { desc = "Search current word" })
map("v", "<leader>sw", "<cmd>lua require('spectre').open_visual()<CR>", { desc = "Search current word" })
map("n", "<leader>sp", "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>", { desc = "Search on current file" })

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fp", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Find document symbols" })
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
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "telescope find all files" })

-- Git keymaps
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "Git blame line" })
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "Undo stage hunk" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", { desc = "Diff this" })

-- Comment.nvim integration
map("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })
map("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle comment" })

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

vim.schedule(function()
  local present, wk = pcall(require, "which-key")
  if not present then
    return
  end

  wk.register({
    F = {
      name = "+Flutter",
      c = { "<cmd>Telescope flutter commands<cr>", "Open Flutter Commands" },
      d = { "<cmd>FlutterDevices<cr>", "Flutter Devices" },
      e = { "<cmd>FlutterEmulators<cr>", "Flutter Emulators" },
      r = { "<cmd>FlutterReload<cr>", "Hot Reload App" },
      R = { "<cmd>FlutterRestart<cr>", "Hot Restart App" },
      q = { "<cmd>FlutterQuit<cr>", "Quit Running App" },
      L = { "<cmd>FlutterIntlGenerate<cr>", "Flutter Intl: Generate Classes" },
      l = { "<cmd>FlutterIntlDownload<cr>", "Flutter Intl: Download .arb" },
      v = { "<cmd>Telescope flutter fvm<cr>", "Flutter Version" },
    },
    T = {
      name = "+Tests",
      t = { "<cmd>lua require('neotest').run.run()<CR>", "Run Nearest Test" },
      f = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', "Run File Tests" },
      o = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Output Summary" },
      g = {
        '<cmd>lua require("neotest").run.run({extra_args="--update-goldens"})<CR>',
        "Update Goldens",
      },
    },
    t = {
      name = "+Trouble",
      r = { "<cmd>Trouble lsp_references<cr>", "References" },
      f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
      d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
      q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
      l = { "<cmd>Trouble loclist<cr>", "LocationList" },
      w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
      t = { "<cmd>TodoTelescope<cr>", "TODO List" },
    },
    g = {
      name = "+Git",
      b = { "<cmd>Gitsigns blame_line<CR>", "Blame line" },
      p = { "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk" },
      r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk" },
      s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
      u = { "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk" },
      d = { "<cmd>Gitsigns diffthis<CR>", "Diff this" },
    },
  }, { prefix = "<leader>" })
end)
