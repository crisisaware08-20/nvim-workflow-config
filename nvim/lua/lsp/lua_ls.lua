vim.lsp.config.lua_ls = {
  cmd = { 'lua-language-server' },
  root_markers = { '.git', '.luarc.json', '.luarc.jsonc' },
  filetypes = { 'lua' },
  settings = {
    Lua = {
      -- Make the server aware of Neovim runtime files
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      -- Tell lua_ls about Neovim's Lua API
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Add additional libraries if needed
          -- "${3rd}/luv/library",
          -- "${3rd}/busted/library",
        },
      },
      -- Disable telemetry
      telemetry = { enable = false },
      -- Configure diagnostics
      diagnostics = {
        -- Recognize vim global
        globals = { 'vim' },
      },
      -- Improve completion
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
}

print(vim.env.VIMRUNTIME)
