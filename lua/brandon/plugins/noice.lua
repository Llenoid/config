local M = {
	"folke/noice.nvim",
	event = "VeryLazy", -- Consider changing to "BufReadPre" if you want faster loading
	lazy = true,
	opts = {
		popupmenu = {
			backend = 'nui'
		},
		-- input = {
		-- 	view = "cmdline",
		-- 	opts = {
		-- 		zindex = 1000, -- Way higher than Mason's 45
		-- 		position = { row = "40%", col = "50%" }, -- Move it slightly so it's centered
		-- 	},
		-- },
		-- LSP configurations
		lsp = {
			signature = {
				auto_open = {
					enabled = false,
				}, -- Automatically show signature help on trigger characters
			},
		},
		inc_rename = {
			border = {
				style = "single",
				padding = { 0, 1 },
			},
		},
		-- Enable useful presets
	 presets = {
    bottom_search = true, -- Use a classic command line
    command_palette = false, -- Position command palette
    long_message_to_split = true, -- Long messages to a split
    -- inc_rename = true, -- Enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- Add a border to hover docs
  },
		-- Command-line view settings
		cmdline = {
			view = "cmdline", -- Use the "classic" command-line view
		},
		-- Routes for filtering specific messages
		routes = {
			{
				-- Skip LSP progress messages for specific clients
				filter = {
					event = "lsp",
					kind = "progress",
					-- cond = function(message)
					-- 	local excluded_clients = { "ltex" } -- Add clients to exclude here
					-- 	local client = vim.tbl_get(message.opts, "progress", "client")
					-- 	return vim.tbl_contains(excluded_clients, client)
					-- end,
				},
				opts = { skip = true },
			},
			{
				view = "notify",
				filter = { event = "msg_showmode" },
			},
			-- This route tells Noice to use the default UI for Mason 
			-- to avoid the "hidden window" problem
			-- {
			-- 	filter = {
			-- 		event = "msg_show",
			-- 		-- Use 'find' instead of 'pattern'
			-- 		find = "mason", 
			-- 	},
			-- 	opts = { skip = true },
			-- },
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",  -- Required dependency for Noice.nvim
		"nvim-mini/mini.notify", -- Lightweight notify plugin
	},
	-- Add key mappings for Noice.nvim functionality
	keys = {
		{
			"<leader>nh",
			":Noice history<CR>",
			desc = "Show Noice History",
			noremap = true,
			silent = true,
		},
		{
			"<leader>nl",
			":Noice last<CR>",
			desc = "Show Last Noice Message",
			noremap = true,
			silent = true,
		},
	},
	-- Highlight groups for better UI customization
	config = function(_, opts)
		-- Apply Noice.nvim setup
		require("noice").setup(opts)

		-- Customize highlight groups
		-- vim.cmd([[
  --           highlight NoiceCmdline guifg=#ffffff guibg=#000000
  --           highlight NoiceLspProgress guifg=#00ff00 guibg=#000000
  --       ]])
	end,
}

return M
