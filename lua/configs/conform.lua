local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = {
      "goimports",
      "gofmt",
      "gomodifytags",
      "iferr",
      "impl",
      "gotests",
      "goimports",
      "dart_format",
      lsp_format = "last",
    },
    python = { "isort", "black" },
    php = { "php_cs_fixer" }, -- atau gunakan "pint" jika pakai Laravel modern
    html = { "prettier" },
    css = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    vue = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    blade = { "blade-formatter" },
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },

  notify_on_error = true,
}

return options
