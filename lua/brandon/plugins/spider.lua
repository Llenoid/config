-- local M = {
-- 	"chrisgrieser/nvim-spider",
-- 	event = "VeryLazy",
-- 	lazy = true,
-- }
--
-- function M.config()
-- 	require("spider").setup({
-- 		skipInsignificantPunctuation = false,
-- 	})
--
-- 	vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
-- 	vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
-- 	vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
-- 	vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
-- end
--
-- return M

local M = {
  "chrisgrieser/nvim-spider",
  keys = {
    { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" }, desc = "Spider-w" },
    { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" }, desc = "Spider-e" },
    { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" }, desc = "Spider-b" },
    { "ge", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" }, desc = "Spider-ge" },
  },
  opts = {
    skipInsignificantPunctuation = false,
  },
}

return M
