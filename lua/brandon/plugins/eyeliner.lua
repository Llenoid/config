-- local M = {
-- 	"jinh0/eyeliner.nvim",
-- 	event = "VeryLazy",
-- }
--
-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.api.nvim_set_hl(0, "EyelinerPrimary", { bold = true, underline = false })
-- 	end,
-- })
--
-- function M.config()
-- 	require("eyeliner").setup({
-- 		highlight_on_key = true,
-- 		dim = true,
-- 	})
-- end
--
-- return M
local M = {
  "jinh0/eyeliner.nvim",
  keys = { "f", "F", "t", "T" }, -- Plugin only loads when you start a jump
  config = function()
    -- Set the highlights inside the config so it only runs once the plugin wakes up
    vim.api.nvim_set_hl(0, "EyelinerPrimary", { bold = true, underline = false })
    
    require("eyeliner").setup({
      highlight_on_key = true,
      dim = true,
    })
  end,
}

return M
