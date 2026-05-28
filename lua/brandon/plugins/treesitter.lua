local M = {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		lazy = true,
		build = ":TSUpdate",
		-- branch = "main",
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		dependencies={
		"OXY2DEV/markview.nvim",
		{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" }
		},
		config = function(_, opts)
            -- This forces Neovim to include the parser directory in the runtime path
            local treesitter = require("nvim-treesitter")

						local ensure_installed = {
							"c",
							"cpp",
							"go",
							"lua",
							"python",
							"rust",
							"tsx",
							"javascript",
							"typescript",
							"vim",
							"bash",
							"query",
							"elixir",
							"heex",
							"html",
							"markdown",
							"vimdoc",
							-- "bash",
							"diff",
							"luadoc",
							"markdown_inline",
						}
						treesitter.install(ensure_installed)
						vim.api.nvim_create_autocmd('FileType', {
							callback = function(args)
								local buf, filetype = args.buf, args.match

								local language = vim.treesitter.language.get_lang(filetype)
								if not language then
									return
								end

								-- check if parser exists and load it
								if not vim.treesitter.language.add(language) then
									return
								end

								-- enables syntax highlighting and other treesitter features
								vim.treesitter.start(buf, language)

								-- enables treesitter based indentation
								vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
							end,
						})
						treesitter.setup(opts)

            -- Refresh the runtime path immediately after setup
            vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter")
        end,
		opts = {
			-- Autoinstall languages that are not installed
			auto_install = true,
			-- autotag = {
			-- 	enable = true,
			-- },
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
				-- additional_vim_regex_highlighting = false
			},
			indent = { enable = true, disable = { "ruby" } },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<C-S-space>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["acl"] = "@class.outer",
						["icl"] = "@class.inner",
						["ac"] = "@call.outer",
						["ic"] = "@call.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
						["ai"] = "@conditional.outer",
						["ii"] = "@conditional.inner",
						["a/"] = "@comment.outer",
						["i/"] = "@comment.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["as"] = "@statement.outer",
						["is"] = "@scopename.inner",
						["aA"] = "@attribute.outer",
						["iA"] = "@attribute.inner",
						["aF"] = "@frame.outer",
						["iF"] = "@frame.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
						["gna"] = "@parameter.outer",
						["gni"] = "@parameter.inner",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
						["gpa"] = "@parameter.outer",
						["gpi"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
					-- goto_next = {},
					-- goto_previous = {},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
			indent = {
				enable = true,
				disable = { "yaml" },
			},
			autopairs = { enable = true },
		},
		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	},

	-- {
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	dependencies = "nvim-treesitter/nvim-treesitter",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		enable = false,
	-- 	},
	-- },
	-- {
	-- 	"nvim-treesitter/nvim-treesitter-textobjects",
	-- 	dependencies = "nvim-treesitter/nvim-treesitter",
	-- 	event = "VeryLazy",
	-- },

	-- {
	-- 	"chrisgrieser/nvim-various-textobjs",
	-- 	event = "VeryLazy",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("various-textobjs").setup({ keymaps = { useDefault = false } })
	--
	-- 		vim.keymap.set({ "o", "x" }, "aw", '<cmd>lua require("various-textobjs").subword("outer")<CR>')
	-- 		vim.keymap.set({ "o", "x" }, "iw", '<cmd>lua require("various-textobjs").subword("inner")<CR>')
	-- 	end,
	-- },
}

return M
