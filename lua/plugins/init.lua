return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "php",
        "phpdoc",
        "python",
        "toml",
        "json",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "bash",
        "yaml",
        "dockerfile",
        "ruby",
      },
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
    },
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      vim.g.gitblame_enabled = 0
    end,
  },
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {
        preset = "helix",
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "configs.telescope"
    end,
  },
  -- codeium dan supermaven
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "supermaven-inc/supermaven-nvim" },
      {
        "Exafunction/codeium.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "hrsh7th/nvim-cmp",
        },
        config = function()
          require("codeium").setup {}
        end,
      },
      {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "nvchad.configs.luasnip"
        end,
      },
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
    },
    opts = function()
      return require "configs.cmp"
    end,
  },

  { "akinsho/git-conflict.nvim", version = "*", config = true },
  -- Flutter plugin
  {
    {
      "akinsho/flutter-tools.nvim",
      lazy = false,
      dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
      config = function()
        require("flutter-tools").setup {
          --for windowns only
          -- flutter_path = "/Users/sadabwasim/Documents/development/flutter/bin/flutter.bat",
          ui = {
            border = "rounded",
            notification_style = "plugin",
          },
          outline = {
            open_cmd = "30vnew",
            auto_open = false,
          },
          closing_tags = {
            highlight = "Comment",
            prefix = "// ",
            enabled = true,
          },
          debugger = {
            enabled = true,
            run_via_dap = true,
            register_configurations = function(_)
              require("dap").adapters.dart = {
                type = "executable",
                command = vim.fn.stdpath "data" .. "/mason/bin/dart-debug-adapter",
                args = { "flutter" },
              }

              require("dap").adapters.flutter = {
                type = "executable",
                command = vim.fn.stdpath "data" .. "/mason/bin/dart-debug-adapter",
                args = { "flutter" },
              }

              require("dap").configurations.dart = {
                {
                  type = "dart",
                  request = "launch",
                  name = "Launch flutter",
                  dartSdkPath = "/home/hkn/development/flutter/bin/cache/dart-sdk/",
                  flutterSdkPath = "/home/hkn/development/flutter",
                  program = "${workspaceFolder}/lib/main.dart",
                  cwd = "${workspaceFolder}",
                },
              }

              require("dap").configurations.flutter = {
                {
                  type = "flutter",
                  request = "launch",
                  name = "Launch flutter",
                  dartSdkPath = "/home/hkn/development/flutter/bin/cache/dart-sdk/",
                  flutterSdkPath = "/home/hkn/development/flutter",
                  program = "${workspaceFolder}/lib/main.dart",
                  cwd = "${workspaceFolder}",
                },
              }
              require("dap.ext.vscode").load_launchjs()
            end,
          },
          dev_log = {
            enabled = false,
            open_cmd = "tabedit",
          },
          lsp = {
            -- on_attach = require("lazyvim.util").lsp.on_attach,
            color = {
              enabled = true,
              background = false,
              background_color = { r = 220, g = 223, b = 228 },
              foreground = false,
              virtual_text = true,
              virtual_text_str = "■",
            },
            settings = {
              showTodos = true,
              completeFunctionCalls = true,
              renameFilesWithClasses = "prompt",
              enableSnippets = true,
              enableSdkFormatter = true,
              analysisExcludedFolders = {
                ".dart_tool",
              },
            },
            -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
          },
        }
      end,
    },

    { "dart-lang/dart-vim-plugin" },
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },
}
