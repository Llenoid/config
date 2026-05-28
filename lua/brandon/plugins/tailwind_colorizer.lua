local M = {
	"roobert/tailwindcss-colorizer-cmp.nvim",
	event = "InsertEnter",
	lazy = true,
	-- optionally, override the default options:
	config = function()
		require("tailwindcss-colorizer-cmp").setup({
			color_square_width = 2,
		})
	end,
}

return M
