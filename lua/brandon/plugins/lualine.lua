local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  lazy = true,
  dependencies = {
    { "nvim-mini/mini.icons", opts = {} },
    -- "folke/noice.nvim",
    -- "Mofiqul/vscode.nvim",
    -- "lewis6991/gitsigns.nvim",
		-- {
  --       "f-person/git-blame.nvim",
  --       lazy = false, 
  --   }
  },
}

function M.config()
  local icons = require("mini.icons")

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lazy", "mason", "TelescopePrompt", "noice" },
    callback = function()
      local name = vim.fn.expand("<amatch>")
      name = name:sub(1, 1):upper() .. name:sub(2) -- capitalize
      pcall(vim.api.nvim_buf_set_name, 0, name)
    end,
  })

  local bo = vim.bo
  local fn = vim.fn

  vim.api.nvim_del_mark("M") -- reset on session start

  function markM()
    local markObj = vim.api.nvim_get_mark("M", {})
    local markLn = markObj[1]
    local markBufname = vim.fs.basename(markObj[4])
    if markBufname == "" then
      return ""
    end -- mark not set
    return " " .. markBufname .. ":" .. markLn
  end

  local function currentFile()
    local maxLen = 25

    local ext = fn.expand("%:e")
    -- local ext = ""
    local ft = bo.filetype
    local name = fn.expand("%:t")
    if ft == "octo" and name:find("^%d$") then
      name = "#" .. name
    elseif ft == "TelescopePrompt" then
      name = "Telescope"
    end

    local deviconsInstalled, devicons = pcall(require, "mini.icons")
    local icon = deviconsInstalled and devicons.get_icon(name, ext) or ""
    -- add sourcegraph icon for clarity
    if fn.expand("%"):find("^sg") then
      icon = "󰓁 " .. icon
    end

    -- truncate
    local nameNoExt = name:gsub("%.%w+$", "")
    if #nameNoExt > maxLen then
      name = nameNoExt:sub(1, maxLen) .. "…" .. ext
    end

    if icon == "" then
      return name
    end
    return icon .. " " .. name
  end

  local diff = {
    "diff",
    colored = false,
    -- symbols = { added = icons.git.LineAdded, modified = icons.git.LineModified, removed = icons.git.LineRemoved }, -- Changes the symbols used by the diff.
  }

  local diagnostics = {
    "diagnostics",
    -- sections = { "error", "warn" },
    colored = true, -- Displays diagnostics status in color if set to true.
    always_visible = false, -- Show diagnostics even if there are none.
  }

  local filetype = {
    function()
      local filetype = vim.bo.filetype
      local upper_case_filetypes = {
        "json",
        "jsonc",
        "yaml",
        "toml",
        "css",
        "scss",
        "html",
        "xml",
      }

      if vim.tbl_contains(upper_case_filetypes, filetype) then
        return filetype:upper()
      end

      return filetype
    end,
  }

 --  local git_blame = require("gitblame")
	-- vim.g.gitblame_display_virtual_text = 0

  function isRecording()
    local reg = vim.fn.reg_recording()
    if reg == "" then
      return ""
    end -- not recording
    return "REC @" .. reg
  end

  require("lualine").setup({
    options = {
      component_separators = "|",
      -- section_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      icons_enabled = false,
      -- theme = "poimandres",
      -- theme = "onedark",
      -- theme = "mellifluous",
      -- theme = "visual_studio_code",
      -- theme = "vscode",
      -- theme = "edge",
      -- theme = "one_monokai",
      theme = "tokyonight",
      -- theme = "catppuccin",
      -- theme = "onenord",
      tabline_separators = "",
    },
    tabline = {},
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(res)
            return res:sub(1, 1)
          end,
        },
      },
      lualine_b = {
        {
          "filename",
          path = 1,
        },
        { currentFile, diff },
        { markM },
      },
			lualine_c = {
                -- { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
			},
      lualine_x = {
        filetype,
        -- {
        -- 	require("noice").api.status.message.get_hl,
        -- 	cond = require("noice").api.status.message.has,
        -- },
        -- {
        -- 	require("noice").api.status.command.get,
        -- 	cond = require("noice").api.status.command.has,
        -- 	color = { fg = "#ff9e64" },
        -- },
        -- {
        -- 	require("noice").api.status.mode.get,
        -- 	cond = require("noice").api.status.mode.has,
        -- 	color = { fg = "#ff9e64" },
        -- },
        -- {
        -- 	require("noice").api.status.search.get,
        -- 	cond = require("noice").api.status.search.has,
        -- 	color = { fg = "#ff9e64" },
        -- },
      },
      lualine_y = {
        -- {
        -- 	function()
        -- 		return require("noice").api.status.lsp_progress.get_hl()
        -- 	end,
        -- 	cond = function()
        -- 		return package.loaded["noice"] and require("noice").api.status.lsp_progress.has()
        -- 	end,
        -- },
      },
      lualine_z = {
        {
          -- require("noice").api.status.mode.get,
          -- cond = require("noice").api.status.mode.has,
          -- color = { fg = "#ff9e64" },
          isRecording,
          color = { bg = "#ff9e64" },
        },
      },
    },
    -- extensions = { "quickfix", "man", "fugitive", "oil" },
    extensions = { "quickfix", "man", "fugitive" },
  })
end

return M
