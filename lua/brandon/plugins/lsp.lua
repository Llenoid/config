local M = {
  'neovim/nvim-lspconfig',
  event = { "BufReadPost", "BufNewFile"},
  dependencies = {
    { 'mason-org/mason.nvim', 
      cmd = { "Mason", "MasonInstall", "MasonUpdate" },
      opts = {
        -- ui = { check_outdated_packages_on_open = false, border = "rounded", }
      } },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        map('<leader>ca', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

        -- map('<leader>rr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        -- map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        -- map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

        -- map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

        -- map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

        vim.keymap.set("n", "[d", function()
          vim.diagnostic.jump({ count = -1, float = true })
        end, { desc = "Go to previous [D]iagnostic message" })

        vim.keymap.set("n", "]d", function()
          vim.diagnostic.jump({ count = 1, float = true })
        end, { desc = "Go to next [D]iagnostic message" })

        map("<leader>e", vim.diagnostic.open_float, "Show diagnostic [E]rror messages")

        map("<leader>q", vim.diagnostic.setloclist, "Open diagnostic [Q]uickfix list")

        -- map("<C-d>", function()
        --   local ok, lsp_signature = pcall(require, "lsp_signature")
        --   if ok then
        --     return lsp_signature.toggle_float_win()
        --   end
        -- end, "toggle signature", "i")

        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    local border_style = {
      { "┌", "FloatBorder" },
      { "─", "FloatBorder" },
      { "┐", "FloatBorder" },
      { "│", "FloatBorder" },
      { "┘", "FloatBorder" },
      { "─", "FloatBorder" },
      { "└", "FloatBorder" },
      { "│", "FloatBorder" },
    }

    local prefix_func = function(diagnostic)
      local icons = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "󰀪",
        [vim.diagnostic.severity.INFO] = "󰋽",
        [vim.diagnostic.severity.HINT] = "󰌶",
      }
      return icons[diagnostic.severity] or "●"
    end

    vim.diagnostic.config {
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = border_style,
        source = "if_many",
        header = "",
        prefix = "",
      },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = {
        prefix = prefix_func,
        -- source = 'if_many',
        source = false,
        spacing = 2, format = function(diagnostic)
          -- local diagnostic_message = {
          --   [vim.diagnostic.severity.ERROR] = diagnostic.message,
          --   [vim.diagnostic.severity.WARN] = diagnostic.message,
          --   [vim.diagnostic.severity.INFO] = diagnostic.message,
          --   [vim.diagnostic.severity.HINT] = diagnostic.message,
          -- }
          -- return diagnostic_message[diagnostic.severity]
          return ""
        end,
      },
    }

    -- local capabilities = require('blink.cmp').get_lsp_capabilities()
    local function get_capabilities()
      -- Use the internal lazy cache if possible, or just check the package
      if package.loaded['blink.cmp'] then
        return require('blink.cmp').get_lsp_capabilities()
      end
      local caps = vim.lsp.protocol.make_client_capabilities()
      caps.textDocument.completion.completionItem.snippetSupport = true
      return caps
    end

    local servers = {

      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      },
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.schedule(function()
      require('mason').setup()
      require('mason-lspconfig').setup {
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            local capabilities = get_capabilities()
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            if server_name == 'dartls' then
              require('lspconfig').dartls.setup({
                cmd = { "dart", "language-server", "--protocol=lsp"},
                filetypes = { "dart" },
                init_options = {
                  closingLabels = true,
                  flutterOutline = true,
                  onlyAnalyzeProjectsWithOpenFiles = true,
                  outline = true,
                  suggestFromUnimportedLibraries = true,
                },
                settings = {
                  dart = {
                    completeFunctionCalls = true,
                    showTodos = true,
                  }
                }
              })
            end
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
    end)
  end,
}

return M
