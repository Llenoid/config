local M = {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  lazy = true,
  config = function(_, opts)
    local opts = {
      bind = true,
      handler_opts = {
        border = "single",
      },
      floating_window = false,
      close_timeout = 4000,
      wrap = true,
      max_width = 80,
      hint_enable = true,
      hint_inline = function() return 'eol' end,
    }
    require("lsp_signature").setup(opts)

    vim.keymap.set("i", "<C-k>", function()
      require("lsp_signature").toggle_float_win()
    end, { silent = true, noremap = true, desc = "Toggle Signature" })
  end,
}

return M
