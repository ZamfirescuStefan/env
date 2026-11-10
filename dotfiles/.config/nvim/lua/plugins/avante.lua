return {
  "yetone/avante.nvim",
  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
  event = "VeryLazy",
  init = function()
      vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
          pattern = { "Avante", "AvanteInput" },
          callback = function(ev)
              vim.opt_local.wrap = true
              vim.opt_local.linebreak = true
              vim.opt_local.bufhidden = "hide"
          end,
      })
  end,

  opts = {
    instructions_file = "avante.md",
    provider = "copilot",
    file_selector = {
      provider = "snacks",
      provider_opts = {},
  },
  windows = {
      ask = {
          start_insert = false
      }
  },
  behaviour = {
      auto_approve_tool_permissions = {
        "bash",
        "write_to_file",
        "str_replace",
        "view",
        "grep",
      },
    },
    system_prompt = [[
        You are an expert AI coding assistant.
        CAVEMAN MODE:
        - Omit all conversational filler, pleasantries, and explanations.
        - Output concise technical fragments or direct code blocks.
        - Keep variable names, paths, and code byte-for-byte exact.
        ]],
    providers = {
      copilot = {
        model = "claude-haiku-5.5",
        timeout = 30000, -- timeout in milliseconds
        temperature = 0,
        max_tokens = 4096,
      }
   },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    { "ColinKennedy/mega.cmdparse", dependencies = { "ColinKennedy/mega.logging" } },
    --- The below dependencies are optional,
    "nvim-mini/mini.pick", -- for file_selector provider mini.pick
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "echasnovski/mini.icons",
    {

      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = {
          "markdown",
          "markdown.Avante"
        },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
