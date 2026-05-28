local M = {
	"https://github.com/HiPhish/rainbow-delimiters.nvim",
	event = "VeryLazy",
	config = function()
		require("rainbow-delimiters.setup").setup({
			strategy = {
				-- ...
			},
			query = {
				-- ...
			},
			highlight = {
				"RainbowDelimiterYellow",
				"RainbowDelimiterBlue",
				"RainbowDelimiterGreen",
				"RainbowDelimiterRed",
				"RainbowDelimiterCyan",
				"RainbowDelimiterOrange",
				"RainbowDelimiterViolet",
			},
		})
	end,
}

return M
