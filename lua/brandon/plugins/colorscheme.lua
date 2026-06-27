local M = {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    -- opts = { style = 'night'},
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        style = 'moon',
        styles = {
          comments = { italic = false },
          keywords = { italic = true },
          functions = { italic = false },
          -- variables = { italic = true }
        },
        on_highlights = function(hl, c)
          if hl['@keyword.function'] then
            hl['@keyword.function'].italic = true
          else
            -- If it's not defined, let's link it to the existing Keyword color
            hl['@keyword.function'] = { fg = hl.Keyword.fg, italic = true }
          end

          -- Example for the 'try' keyword which is a control flow keyword
          if hl['@keyword.control'] then
            hl['@keyword.control'].italic = true
          end
          hl.IlluminatedWordText = { bold = true, undercurl = true }
          hl.YankedText = { fg = "#e3eaff", bg = "#ff8758" }

          -- hl.Number = { 
          --   bg = "None",
          --   ctermbg = "none",
          --   style  = "none"
          -- }
          -- hl.Float = { links = "Number" }
          -- hl.makeCommands = { links = "Number" }
          -- hl.Constant     = { bg = "None" }
          -- hl.TSNumber     = { bg = "None" }
          -- hl.TSConstant   = { bg = "None" }
        end,
      }

      vim.cmd.colorscheme 'tokyonight'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et

local N = { 
  'olivercederborg/poimandres.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('poimandres').setup {
      -- leave this setup function empty for default config
      -- or refer to the configuration section
      -- for configuration options
    }
  end,

  -- optionally set the colorscheme within lazy config
  init = function()
    vim.cmd("colorscheme poimandres")
  end
}

local O = {
	"Mofiqul/vscode.nvim",
	opts = {
		transparent = true,
		underline_links = true,
	},
	init = function()
		vim.cmd.colorscheme("vscode")
	end,
}

local P = {
    "ramojus/mellifluous.nvim",
    version = "v0.*", -- uncomment for stable config (some features might be missed if/when v1 comes out)
    config = function()
        require("mellifluous").setup({}) -- optional, see configuration section.
        vim.cmd("colorscheme mellifluous")
    end,
}

local Q = {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
    vim.cmd.colorscheme('rose-pine-moon')
	end
}

local R = {
      'sainnhe/everforest',
      lazy = false,
      priority = 1000,
      config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        vim.g.everforest_enable_italic = true
        vim.cmd.colorscheme('everforest')
      end
    }

local S = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme('catppuccin-frappe')
  end
}

local T = {
 'rmehri01/onenord.nvim',
  name = 'onenord',
  priority = 1000,
  config = function ()
    vim.cmd.colorscheme('onenord')
  end
}

return T
