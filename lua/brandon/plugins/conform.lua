local M = {
  "stevearc/conform.nvim",
  cmd = { "ConformInfo" },
  keys = {
    -- {
    --   "<leader>f",
    --   function()
    --     require("conform").format({ async = true, lsp_format = "fallback" })
    --   end,
    --   mode = "",
    --   desc = "[F]ormat buffer",
    -- },
    {
      "<leader>fb",
      function()
        require("conform").format({async = false, timeout_ms = 500, lsp_fallback = true, lsp_format = "fallback"})
      end,
      mode = {"n", "v"},
      desc = "[F]ormat buffer"
    },
    -- {
    --   "<leader>mp",
    --   function()
    --     require("conform").format({
    --       lsp_fallback = true,
    --       async = false,
    --       timeout_ms = 500,
    --     })
    --   end,
    --   mode = { "n", "v" },
    --   desc = "Format file or range (in visual mode)"
    -- }
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = "fallback",
            lsp_fallback = true,
          }
        end
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
        python = { "ruff", "black", "isort" },
        rust = { "rustfmt" },
        go = { "gofmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        ocaml = { "ocamlformat" },
        ruby = { "rubyfmt" },
        handlebars = { "djlint" },
        dart = { "dart_format" }
      },
    },
    config = function()
      local conform = require("conform")
      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "Format file or range (in visual mode)" })

      vim.api.nvim_create_augroup("DisableAutoformat", { clear = true })
      vim.api.nvim_create_autocmd("BufEnter", {
        group = "DisableAutoformat",
        pattern = "*",
        callback = function(args)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
            -- print("autoformatting disabled")
            vim.notify("Autoformatting disabled...", vim.log.levels.INFO)
            return
          end
          -- print("autoformatting...")
          require("conform").format({ bufnr = args.buf }, function(err)
            conform.format()
            if err then
              local message = err .. ". Formatting using LSP"
              vim.notify(message, vim.log.levels.WARN)
              vim.lsp.buf.format()
            end
          end)
        end,
      })

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
          desc = "Disable autoformat-on-save",
          bang = true,
        })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
          desc = "Re-enable autoformat-on-save",
        })
    end
  }
  -- vim: ts=2 sts=2 sw=2 et

return M
