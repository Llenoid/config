local augroup = vim.api.nvim_create_augroup("brandon-autocmds", { clear = true })

vim.keymap.set("n", "<leader>pa", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("file:", path)
end)

-- -- Return to last edit position when opening files
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   group = augroup,
--   callback = function()
--     local mark = vim.api.nvim_buf_get_mark(0, '"')
--     local lcount = vim.api.nvim_buf_line_count(0)
--     if mark[1] > 0 and mark[1] <= lcount then
--       pcall(vim.api.nvim_win_set_cursor, 0, mark)
--     end
--   end,
-- })

-- Automatically save new files ONLY if they aren't empty, 
-- and reset the "modified" flag so you can quit easily.
vim.api.nvim_create_autocmd("BufNewFile", {
  group = brandon_group,
  callback = function()
    vim.schedule(function()
      local buf = vim.api.nvim_get_current_buf()
      local name = vim.api.nvim_buf_get_name(buf)
      
      if name ~= "" then
        -- 1. Write the file to disk to wake up LSP/Mason
        vim.cmd("silent! write")
        
        -- 2. If the buffer is still effectively empty, 
        -- mark it as "unmodified" so :q works without [!]
        if vim.api.nvim_buf_line_count(buf) <= 1 and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == "" then
          vim.bo[buf].modified = false
        end
      end
    end)
  end,
})

-- Return to last edit position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function(args)
    -- GUARD 1: Don't run on empty files or new files
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if line_count <= 1 then return end

    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    -- GUARD 2: Check if the mark is actually within the current file's range
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    local filetype = vim.bo.filetype

    if filetype == "oil" or filetype == "Oil" then
      return
    end

    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

vim.api.nvim_create_user_command("LspInfo", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    print("No LSP clients attached to current buffer")
  else
    for _, client in ipairs(clients) do
      print("LSP: " .. client.name .. " (ID: " .. client.id .. ")")
    end
  end
end, { desc = "Show LSP client info" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  pattern = { "*" },
  callback = function()
    vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { link = "DiagnosticUnnecessary", undercurl = true })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  group = augroup,
  pattern = { "*" },
  callback = function()
    local dirname = vim.fn.getcwd():match("([^/]+)$")
    vim.opt.titlestring = dirname
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup,
  pattern = {
    "netrw",
    "Jaq",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "oil",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
  },
  callback = function(event)
    local opts = { buffer = event.buf, silent = true, nowait = true }
    -- Map both Esc and q for instant exit
    vim.keymap.set("n", "<Esc>", function() pcall(vim.api.nvim_win_close, 0, true) end, opts)
    vim.keymap.set("n", "q", function() pcall(vim.api.nvim_win_close, 0, true) end, opts)
    vim.opt_local.buflisted = false
  end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
  group = augroup,
  callback = function()
    vim.cmd("quit")
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup,
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_set_hl(0, "CustomYank", { 
  bg = "#ffc4a8", -- Soft pastel orange background
  fg = "#1a1a1a", -- Dark gray text for crisp legibility
  bold = true     
})

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({ higroup = "CustomYank" })
  end,
  group = highlight_group,
  pattern = "*",
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  group = augroup,
  callback = function()
    -- Only proceed if the global LuaSnip table exists (meaning it's loaded)
    if _G.luasnip and luasnip.expand_or_jumpable() then
      vim.cmd([[silent! lua require("luasnip").unlink_current()]])
    end
  end,
})

-- Show linters for the current buffer's file type
vim.api.nvim_create_user_command("LintInfo", function()
  local filetype = vim.bo.filetype
  local linters = require("lint").linters_by_ft[filetype]

  if linters then
    print("Linters for " .. filetype .. ": " .. table.concat(linters, ", "))
  else
    print("No linters configured for filetype: " .. filetype)
  end
end, {})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "qf",
  callback = function(event)
    local opts = { buffer = event.buf, silent = true, nowait = true }

    -- Move Down and Jump to the file immediately
    vim.keymap.set("n", "<C-j>", "j<CR>zz<C-w>p", opts)
    
    -- Move Up and Jump to the file immediately
    vim.keymap.set("n", "<C-k>", "k<CR>zz<C-w>p", opts)

    -- If you also want C-n/C-p to do the same
    vim.keymap.set("n", "<C-n>", "j<CR>zz<C-w>p", opts)
    vim.keymap.set("n", "<C-p>", "k<CR>zz<C-w>p", opts)
  end,
})

vim.api.nvim_create_augroup("JSLogMacro", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "JSLogMacro",
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
    vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa'," .. esc .. "pa)")
  end,
})


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
