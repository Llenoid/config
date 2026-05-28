local M = {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
  ft = { "markdown", "codecompanion" },
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  -- opts = function(_, opts)
  --   table.insert(opts, {
  --     enabled = true,
  --   })
  --
  --   vim.api.nvim_create_user_command("MarkdownDisable", function(args)
  --     vim.cmd("lua require('render-markdown').disable()")
  --   end, {
  --     desc = "Disable markdown rendering",
  --     bang = true,
  --   })
  --
  --   vim.api.nvim_create_user_command("MarkdownEnable", function()
  --     vim.cmd("lua require('render-markdown').enable()")
  --   end, {
  --     desc = "Re-enable markdown rendering",
  --   })
  -- end,
  opts = {}
}

return M
