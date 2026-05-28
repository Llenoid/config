local M = {
  "steschwa/git-blame.nvim",
  event = "VeryLazy",
lazy = true,
  keys = {
    { "<leader>tb", "<cmd>GitBlameLine<cr>", desc = "Git blame current line" }
  },
 opts = {
        lines = {
            {
                function(blame)
                    return { text = blame.sha:sub(1, 7) .. "  ", hl = "Comment" }
                end,
                function(blame)
                    return { text = vim.fn.strftime("%Y-%m-%d", blame.timestamp) }
                end,
            },
            {
                function(blame)
                    return { text = blame.author, hl = "Bold" }
                end,
            },
            {}, -- empty line
            {
                function(blame)
                    return { text = blame.message }
                end,
            },
        },
        window = {
            border = "rounded",
        }
    }
}

return {}
