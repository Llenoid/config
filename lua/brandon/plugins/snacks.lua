local picker_opts = require("brandon.plugins.snack_options.picker_opts")
local picker_keys = require("brandon.plugins.snack_options.picker_keys")

local M = {
  "folke/snacks.nvim",
  priority = 1000,
  event = "VeryLazy",
  lazy = true,
  ---@type snacks.Config
  opts = {
    bigfile = {
      enabled = true,
      size = 1.5 * 1024 * 1024
    },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = {
      enabled = true,
      priority = 1, -- Keep it low so text renders first
      char = "│",
      only_scope = true, -- ONLY calculate the current scope (massive speed boost)
      only_current = true,
    },
    input = { enabled = false },
    image = { enabled = true },
    -- picker = vim.tbl_deep_extend("force", { enabled = true }, picker_opts or {}),
    picker = picker_opts,
    -- picker = { enabled = true },
    notifier = { enabled = false },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
  },
  keys = picker_keys,
}

return M
