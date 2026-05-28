-- picker = vim.tbl_deep_extend("force", { enabled = true }, picker_opts),

local M = {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	dependencies = "nvim-mini/mini.icons",
	branch = "main",
  -- cmd = "FzfLua",
	config = function()
		local setup = require("brandon.plugins.fzf_options.setup")
		local keymaps = require("brandon.plugins.fzf_options.keymaps")

		for _, keymap in ipairs(keymaps) do
			vim.keymap.set(keymap.mode or "n", keymap[1], keymap[2], { desc = keymap.desc, nowait = keymap.nowait })
		end
		-- calling `setup` is optional for customization
		local ok, fzf = pcall(require, "fzf-lua")
		if not ok then
			return
		end
		-- fzf.setup({ "telescope", setup })
		-- fzf.setup({ "fzf-native", setup })
		-- fzf.setup({ "skim", setup })
		fzf.setup(setup)
	end,
}

return {}
