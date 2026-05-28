local icons_opts = {
	file = {
		[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
		["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
	},
	filetype = {
		dotenv = { glyph = "", hl = "MiniIconsYellow" },
	},
}

local indentscope_opts = {
	symbol = "│",
	options = { try_as_border = true },
}

local split_join_opts = {
	mappings = {
		toggle = "<space>tsj",
		split = "",
		join = "",
	},
}

local surround_opts = {
	mappings = {
		add = "gsa", -- Add surrounding in Normal and Visual modes
		delete = "gsd", -- Delete surrounding
		find = "gsf", -- Find surrounding (to the right)
		find_left = "gsF", -- Find surrounding (to the left)
		highlight = "gsh", -- Highlight surrounding
		replace = "gsc", -- Replace surrounding
		update_n_lines = "gsn", -- Update `n_lines`

		suffix_last = "l", -- Suffix to search with "prev" method
		suffix_next = "n", -- Suffix to search with "next" method
	},
}

local align_opts = {
	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		start = "ga",
		start_with_preview = "gA",
	},
}

local M = {
	"nvim-mini/mini.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		local ai_opts = {
			custom_textobjects = {
				F = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
				o = require("mini.ai").gen_spec.treesitter({
					a = { "@conditional.outer", "@loop.outer" },
					i = { "@conditional.inner", "@loop.inner" },
				}),
			},
			{ n_lines = 50 },
		}
		require("mini.icons").setup(icons_opts)

		vim.schedule(function ()
			require("mini.ai").setup(ai_opts)
			require("mini.align").setup(align_opts)
			-- require("mini.indentscope").setup(indentscope_opts)
			require("mini.surround").setup(surround_opts)
			require("mini.splitjoin").setup(split_join_opts)
			require("mini.extra").setup({})
			require("mini.comment").setup({})
			-- require("mini.colors").setup({})
			-- require("mini.notify").setup({})
			-- require('mini.pick').setup({})
		end)
	end,
}
return M
