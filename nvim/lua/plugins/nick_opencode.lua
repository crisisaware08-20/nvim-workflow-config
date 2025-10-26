-- plugins/nick_opencode.lua

-- ═══════════════════════════════════════════════════════════
-- DUAL-MODE CONFIGURATION
-- ═══════════════════════════════════════════════════════════
-- Supports both:
-- 1. Global mode: Multi-project on fixed port 12345
-- 2. Auto-discover mode: Project-specific, CWD-based discovery

-- Initialize mode (default to auto-discover)
vim.g.opencode_mode = vim.g.opencode_mode or 'auto-discover'

-- Helper function to switch between modes
local function set_opencode_mode(mode)
  vim.g.opencode_mode = mode
  
  -- Update the port in both vim.g.opencode_opts and the plugin's internal config
  local new_port = mode == 'global' and 12345 or nil
  vim.g.opencode_opts = vim.g.opencode_opts or {}
  vim.g.opencode_opts.port = new_port
  
  -- CRITICAL: Update the plugin's internal config that it actually uses
  require('opencode.config').opts.port = new_port
  
  local port_info = mode == 'global' and ' (port 12345)' or ' (auto-discover CWD)'
  vim.notify('OpenCodeAI mode: ' .. mode .. port_info, vim.log.levels.INFO)
end

-- ═══════════════════════════════════════════════════════════
-- CUSTOM CONTEXT FUNCTIONS (for global mode support)
-- ═══════════════════════════════════════════════════════════
-- These override the default contexts to use absolute paths in global mode
-- and relative paths in auto-discover mode

local function get_file_path(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" then
    return nil
  end
  
  -- Use absolute paths in global mode, relative in auto-discover mode
  if vim.g.opencode_mode == 'global' then
    return vim.fn.fnamemodify(name, ":p")  -- Absolute path
  else
    return vim.fn.fnamemodify(name, ":.")
  end
end

local function last_used_valid_win()
  local last_used_win = 0
  local latest_lastused = 0
  
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf })
    if vim.api.nvim_buf_is_loaded(buf) and buftype == "" then
      local last_used = vim.fn.getbufinfo(buf)[1].lastused or 0
      if last_used > latest_lastused then
        latest_lastused = last_used
        last_used_win = win
      end
    end
  end
  
  return last_used_win
end

local custom_contexts = {
  ["@buffer"] = {
    description = "Current buffer",
    value = function()
      return get_file_path(vim.api.nvim_win_get_buf(last_used_valid_win()))
    end
  },
  ["@cursor"] = {
    description = "Cursor position",
    value = function()
      local win = last_used_valid_win()
      local pos = vim.api.nvim_win_get_cursor(win)
      local line = pos[1]
      local col = pos[2] + 1
      return string.format("%s:L%d:C%d", get_file_path(vim.api.nvim_win_get_buf(win)), line, col)
    end
  },
  ["@selection"] = {
    description = "Selected text",
    value = function()
      local is_visual = vim.fn.mode():match("[vV\22]")
      local path = get_file_path(vim.api.nvim_win_get_buf(last_used_valid_win()))
      if not path then
        return nil
      end
      
      local _, start_line = unpack(vim.api.nvim_win_call(last_used_valid_win(), function()
        return vim.fn.getpos(is_visual and "v" or "'<")
      end))
      local _, end_line = unpack(vim.api.nvim_win_call(last_used_valid_win(), function()
        return vim.fn.getpos(is_visual and "." or "'>")
      end))
      if start_line > end_line then
        start_line, end_line = end_line, start_line
      end
      
      return string.format("%s:L%d-%d", path, start_line, end_line)
    end
  },
}

-- Set initial configuration based on current mode
vim.g.opencode_opts = {
  port = vim.g.opencode_mode == 'global' and 12345 or nil,
  -- Override default contexts to use mode-aware paths
  contexts = {
    ["@buffer"] = custom_contexts["@buffer"],
    ["@buffers"] = { description = "Open buffers", value = require("opencode.context").buffers },
    ["@cursor"] = custom_contexts["@cursor"],
    ["@selection"] = custom_contexts["@selection"],
    ["@visible"] = { description = "Visible text", value = require("opencode.context").visible_text },
    ["@diagnostics"] = { description = "Current buffer diagnostics", value = require("opencode.context").diagnostics },
    ["@quickfix"] = { description = "Quickfix list", value = require("opencode.context").quickfix },
    ["@diff"] = { description = "Git diff", value = require("opencode.context").git_diff },
    ["@grapple"] = { description = "Grapple tags", value = require("opencode.context").grapple_tags },
  },
  -- Your additional configuration, if any — see `lua/opencode/config.lua`
}

-- Required for `opts.auto_reload`
vim.opt.autoread = true

-- Show current mode on startup
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.defer_fn(function()
      local mode = vim.g.opencode_mode or 'auto-discover'
      local port_info = mode == 'global' and ' (port 12345)' or ' (CWD-based)'
      vim.notify('OpenCodeAI: ' .. mode .. port_info, vim.log.levels.INFO, { title = 'OpenCode' })
    end, 500)
  end,
})

-- ═══════════════════════════════════════════════════════════
-- MODE SWITCHING KEYMAPS
-- ═══════════════════════════════════════════════════════════
-- Switch to global mode (multi-project, port 12345)
vim.keymap.set('n', '<leader>og', function()
  set_opencode_mode('global')
end, { desc = 'OpenCode: Switch to Global mode (port 12345)' })

-- Switch to auto-discover mode (project-specific)
vim.keymap.set('n', '<leader>ol', function()
  set_opencode_mode('auto-discover')
end, { desc = 'OpenCode: Switch to Local/Auto-discover mode' })

-- Show current mode
vim.keymap.set('n', '<leader>om', function()
  local mode = vim.g.opencode_mode or 'auto-discover'
  local port_info = mode == 'global' and ' (port 12345)' or ' (CWD-based discovery)'
  vim.notify('Current OpenCodeAI mode: ' .. mode .. port_info, vim.log.levels.INFO, { title = 'OpenCode' })
end, { desc = 'OpenCode: Show current mode' })

-- ═══════════════════════════════════════════════════════════
-- STANDARD OPENCODE KEYMAPS
-- ═══════════════════════════════════════════════════════════
vim.keymap.set('n', '<leader>ot', function() require('opencode').toggle() end, { desc = 'Toggle embedded' })
vim.keymap.set('n', '<leader>oa', function() require('opencode').ask('@cursor: ' ) end, { desc = 'Ask about this' })
vim.keymap.set('v', '<leader>oa', function() require('opencode').ask('@selection: ' ) end, { desc = 'Ask about selection' })
vim.keymap.set('n', '<leader>o+', function() require('opencode').prompt('@buffer', { append = true }) end, { desc = 'Add buffer to prompt' })
vim.keymap.set('v', '<leader>o+', function() require('opencode').prompt('@selection', { append = true }) end, { desc = 'Add selection to prompt' })
vim.keymap.set('n', '<leader>oe', function() require('opencode').prompt('Explain @cursor and its context') end, { desc = 'Explain this code' })
vim.keymap.set('n', '<leader>on', function() require('opencode').command('session_new') end, { desc = 'New session' })
vim.keymap.set('n','<S-C-u>', function() require('opencode').command('messages_half_page_up') end, { desc = 'Messages half page up' })
vim.keymap.set('n', '<S-C-d>', function() require('opencode').command('messages_half_page_down') end, { desc = 'Messages half page down' })
vim.keymap.set({ 'n', 'v' }, '<leader>os', function() require('opencode').select() end, { desc = 'Select prompt' })
