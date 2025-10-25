-- List configured LSP servers
vim.api.nvim_create_user_command('LspList', function()
  local servers = vim.tbl_keys(vim.lsp.config)
  if #servers == 0 then
    print("No LSP servers configured")
  else
    print("Configured LSP servers:")
    for _, name in ipairs(servers) do
      print("  - " .. name)
    end
  end
end, {})

-- Show LSP client information (mimics old :LspInfo)
vim.api.nvim_create_user_command('LspInfo', function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  
  if #clients == 0 then
    print("No LSP clients attached to current buffer")
    print("\nConfigured servers: " .. table.concat(vim.tbl_keys(vim.lsp.config), ", "))
  else
    print("LSP clients attached to buffer " .. vim.api.nvim_get_current_buf() .. ":")
    print("")
    for _, client in ipairs(clients) do
      print("Client: " .. client.name .. " (id: " .. client.id .. ")")
      print("  Root dir: " .. (client.root_dir or "N/A"))
      print("  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))
      print("  Autostart: " .. tostring(client.config.autostart ~= false))
      print("")
    end
  end
  
  -- Show all active clients
  local all_clients = vim.lsp.get_clients()
  if #all_clients > #clients then
    print("Other active LSP clients:")
    for _, client in ipairs(all_clients) do
      local attached_to_current = false
      for _, c in ipairs(clients) do
        if c.id == client.id then
          attached_to_current = true
          break
        end
      end
      if not attached_to_current then
        print("  - " .. client.name .. " (id: " .. client.id .. ")")
      end
    end
  end
end, {})
