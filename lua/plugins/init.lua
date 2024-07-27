local cmp = require "cmp"
local luasnip = require "luasnip"
local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end
return {
  {
    "jvgrootveld/telescope-zoxide",
    lazy = true,
    specs = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = {
          "jvgrootveld/telescope-zoxide",
        },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    event = "BufWritePre",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    opts = {
      -- NOTE: this function does not merge in place and needs to be
      --       returned at the end of the function
      mapping = {
        ["<CR>"] = cmp.config.disable,
        ["<A-n>"] = cmp.mapping(function()
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          end
        end, { "i", "s" }),
        ["<A-p>"] = cmp.mapping(function()
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function()
          cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
        end, { "i", "s" }),
        ["<C-j>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
          else
            cmp.complete()
          end
        end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.confirm { select = true }
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.config.disable,
      },
      experimental = {
        ghost_text = true,
      },
    },
  },
  {
    "max397574/better-escape.nvim",
    event = "BufWritePre",
    config = function()
      require("better_escape").setup()
    end,
  },
  { "wakatime/vim-wakatime", lazy = false },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = {
      throttle = true,
      max_lines = 0,
      patterns = {
        default = {
          "class",
          "function",
          "method",
        },
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "folke/todo-comments.nvim",
    opts = {},
    event = "VeryLazy",
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      views = {
        mini = {
          win_options = {
            winblend = 0,
          },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
  },

  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    keys = { "<C-d>", "<C-u>" },
    config = function()
      require("neoscroll").setup()
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      extensions_list = { "fzf", "terms", "zoxide" },

      extensions = {
        media = {
          backend = "ueberzug",
        },
      },
    },

    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
  {
    "DreamMaoMao/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },

    keys = {
      { "<leader>y", "<cmd>Yazi<CR>", desc = "󰇥 Toggle Yazi" },
    },
  },
  { "NvChad/nvim-colorizer.lua", enabled = false },
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    cmd = "HighlightColors",
    opts = {
      enabled_named_colors = false,
      render = "virtual",
      virtual_symbol_position = "inline",
      enable_tailwind = true,
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "clangd",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "cpp",
      },
    },
  },
}
