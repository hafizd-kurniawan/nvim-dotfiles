return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "BufReadPost",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesitter-context").setup {
      enable = true, -- Enable this plugin
      max_lines = 3, -- How many lines the context window should span.
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded.
      mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
      multiwindow = true, -- Enable multiwindow support.
    }
  end,
}
