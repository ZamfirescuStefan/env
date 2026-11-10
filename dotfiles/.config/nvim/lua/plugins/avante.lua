return {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- add any opts here
    -- this file can contain specific instructions for your project
    instructions_file = "avante.md",
    provider = "copilot",
    providers = {
      copilot = {
        model = "claude-haiku-5.5",
        timeout = 30000, -- timeout in milliseconds
        temperature = 0,
        max_tokens = 4096,
      },

      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-5-5",
        extra_request_body = {
          max_tokens = 20480,
        },
      },
      moonshot = {
        __inherited_from = "openai",
        endpoint = "https://api.moonshot.ai/v1",
        api_key_name = "MOONSHOT_API_KEY",
        model = "kimi-k3",
        extra_request_body = {
          max_tokens = 32768,
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    { "ColinKennedy/mega.cmdparse", dependencies = { "ColinKennedy/mega.logging" } },
    --- The below dependencies are optional,
    "nvim-mini/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "folke/snacks.nvim", -- for input provider snacks
    "echasnovski/mini.icons",
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = {
          "markdown",
          "markdown.Avante" -- until a fix for https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/715 is found
        },

      },
      ft = { "markdown", "Avante" },
    },
  },
}
