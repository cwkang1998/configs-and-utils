-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  { "ms-jpq/coq_nvim" },
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup {
        style = "deep"
      }
    end
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4',
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup {
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit", "gitrebase", "svn", "hgcommit",
        },
        lastplace_open_folds = true,
      }
    end,
  },
}

lvim.colorscheme = "onedark"

-- Dap configuration
lvim.builtin.dap.on_config_done = function()
  local dap = require("dap")
  -- Codelldb configuration for debugging.
  dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
      command = "/Users/chen/.local/share/lvim/mason/bin/codelldb",
      args = { "--port", "${port}" },
    }
  }

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
    },
  }
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp

  -- TS & JS configuration for debugging
  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "/Users/chen/.local/share/lvim/mason/bin/js-debug-adapter",
      args = { "${port}" }
    }
  }

  for _, language in ipairs({ 'typescript', 'javascript' }) do
    dap.configurations[language] = {
      {
        name = 'Launch',
        type = 'pwa-node',
        request = 'launch',
        program = '${file}',
        rootPath = '${workspaceFolder}',
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        skipFiles = { '<node_internals>/**' },
        protocol = 'inspector',
        -- console = 'integratedTerminal',
      },
      {
        name = 'Attach to node process',
        type = 'pwa-node',
        request = 'attach',
        rootPath = '${workspaceFolder}',
        processId = require('dap.utils').pick_process,
      },
    }
  end
end
