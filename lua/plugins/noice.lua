return {
  "folke/noice.nvim",
  event = "VeryLazy",
  enabled = true,
  opts = {
    -- add any options here
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    }

    vim.api.nvim_create_autocmd("BufWritePost", {
      callback = function()
        vim.notify(" ✅File saved: " .. vim.fn.expand "%:p", vim.log.levels.INFO, {
          title = "Save Notification",
          timeout = 2000, -- waktu tampil (ms)
        })
      end,
    })
  end,
}
