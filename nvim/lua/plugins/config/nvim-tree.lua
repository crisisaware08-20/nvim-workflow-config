local function get_dynamic_width()
  local columns = vim.o.columns
  return math.floor(columns * 0.5)  -- Adjust the multiplier as needed
end

require('nvim-tree').setup {
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    float = {
      enable = true,
      open_win_config = {
        relative = 'editor',
        border = 'rounded',
        width = get_dynamic_width(),
        height = 30,
        row = 1,
        col = 10,
      },
    },
    width = 70,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  update_focused_file = {
    enable = true,   -- Enables the feature to update the focused file
    update_cwd = true, -- Changes the cwd of the tree to that of the file
  }
}
