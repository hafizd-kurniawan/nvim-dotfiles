require "nvchad.options"

local opt = vim.opt
local g = vim.g
local o = vim.o

-- vim.o.laststatus = 3
-- vim.o.tabline = vim.o.stl
-- vim.o.showtabline = 2

-- Encoding
opt.encoding = "utf-8"
vim.opt.mouse = ""

-- Cursorline settings
opt.cursorline = true
opt.cursorlineopt = "number" -- Hanya menyorot nomor baris

-- File handling
opt.backup = false
opt.swapfile = false -- Sebelumnya true, diubah ke false agar sesuai dengan tujuan mengurangi penggunaan disk
opt.undofile = true -- Mengaktifkan undo yang persisten

-- Scrolling behavior
opt.scrolloff = 10 -- Minimal 10 baris di atas dan bawah saat menggulir
opt.smoothscroll = true -- Pengguliran halus

-- Numbering
opt.number = true -- Menampilkan nomor baris
opt.relativenumber = true -- Gunakan nomor relatif
opt.numberwidth = 1 -- Lebar kolom nomor baris

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true -- Ganti tab dengan spasi
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- Wrapping
opt.wrap = true -- Nonaktifkan pembungkusan baris panjang

-- Keyboard behavior
opt.backspace = "indent,eol,start"
opt.whichwrap:append "<>[]hl" -- Memungkinkan navigasi antar baris dengan tombol panah

-- Clipboard
opt.clipboard = "unnamedplus"

-- Search behavior
opt.ignorecase = true -- Tidak membedakan huruf besar/kecil
opt.smartcase = true -- Case-sensitive jika ada huruf besar

-- Mouse settings
opt.mouse = "a" -- Aktifkan mouse di semua mode
o.mousemoveevent = true -- Mengaktifkan event pergerakan mouse (butuh Neovim 0.9+)

-- UI enhancements
opt.termguicolors = true -- True color support
opt.signcolumn = "yes" -- Selalu tampilkan kolom tanda
opt.laststatus = 3 -- Global status line
opt.showmode = false -- Sembunyikan mode (-- INSERT --)

-- Hiding intro message
opt.shortmess:append "sI"

-- Splitting behavior
opt.splitbelow = true -- Horizontal split dibuka di bawah
opt.splitright = true -- Vertical split dibuka di kanan

-- Update & Timeout settings
opt.timeoutlen = 400 -- Waktu tunggu untuk shortcut
opt.updatetime = 250 -- Waktu tunggu untuk event plugin (misalnya Gitsigns)

-- Folding settings
opt.foldenable = true
opt.foldcolumn = "auto"
opt.foldnestmax = 0
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.fillchars = {
  fold = " ",
  foldopen = "",
  foldsep = " ",
  foldclose = "",
  stl = " ",
  eob = " ",
}

-- Conceal settings
opt.conceallevel = 2
opt.concealcursor = ""

-- TMUX handling
if vim.env.TMUX then
  opt.laststatus = 3
else
  opt.laststatus = 3
end

-- -- Debug Adapter Protocol (DAP)
-- g.dap_virtual_text = true
--
-- Bookmark settings
g.bookmark_sign = ""

opt.breakindent = true
opt.breakindentopt = { "shift:2", "min:40", "sbr" }
-- opt.tabstop = 2
-- opt.shiftwidth = 2

--
-- -- Query linting
-- g.query_lint_on = { "BufWrite" }
