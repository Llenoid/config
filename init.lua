if vim.loader then
  vim.loader.enable()
end

require("brandon.config")

if vim.g.vscode then
  vim.opt.clipboard:append("unnamedplus")
end

-- vim.cmd([[
-- silent! exe 'set background='.$NVIM_COLORSCHEME_BG
-- silent! exe 'colorscheme '.$NVIM_COLORSCHEME
-- ]])
