vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" }) --  Use CTRL+<hjkl> to switch between windows

-- vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" }) -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier

local opts = { noremap = true, silent = true , nowait = true}

-- buffers
vim.keymap.set("n", "H", "<cmd>bprevious<cr>", vim.tbl_deep_extend("force", opts, { desc = "Prev Buffer" }))
vim.keymap.set("n", "L", "<cmd>bnext<cr>", vim.tbl_deep_extend("force", opts, { desc = "Next Buffer" }))
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", vim.tbl_deep_extend("force", opts, { desc = "Prev Buffer" }))
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", vim.tbl_deep_extend("force", opts, { desc = "Next Buffer" }))
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", vim.tbl_deep_extend("force", opts, { desc = "Switch to Other Buffer" }))
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", vim.tbl_deep_extend("force", opts, { desc = "Delete Buffer and Window" }))

 -- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc><Esc>", function()
	vim.cmd("nohlsearch")
end, vim.tbl_deep_extend( "force", opts, { desc = "dismiss notify popup and clear hlsearch" } ))

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("v", "<C-S-j>", ":m '>+1<CR>gv=gv", { desc = "Move highlighted line down" })
vim.keymap.set("v", "<C-S-k>", ":m '<-2<CR>gv=gv", { desc = "Move highlighted line up" })

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "J", "mzJ`z", { desc = "Keep cursor in place when using J" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Keep cursor in middle when jumping" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Keep cursor in middle when jumping" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Keep searched terms in the middle" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Keep searched terms in the middle" })

vim.keymap.set("n", "<C-i>", "<C-i>", { noremap = true, silent = true })

-- Clear search, diff update and redraw, taken from runtime/lua/_editor.lua
vim.keymap.set(
	"n",
	"<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- commenting
-- vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
-- vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- vim.keymap.set("n", "[N", "<cmd>cprev<cr>", { desc = "Previous Quickfix" })
-- vim.keymap.set("n", "]n", "<cmd>cnext<cr>", { desc = "Next Quickfix" })

-- highlights under cursor
vim.keymap.set("n", "<leader>zs", "<cmd>Inspect<cr>", { desc = "Inspect Pos" })
vim.keymap.set("n", "<leader>ZS", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- windows
vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "Windows", remap = true })
vim.keymap.set("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split Window Right", remap = true })
vim.keymap.set("n", "<leader>_", "<cmd>split<cr>", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>dw", "<C-W>c", { desc = "Delete Window", remap = true })

-- Increase/decrease splits
vim.keymap.set("n","<C-Up>",":resize +2<CR>", {desc = "Increase window height"})
vim.keymap.set("n","<C-Down>",":resize -2<CR>",{desc = "Decrease window height"})
vim.keymap.set("n","<C-Right>",":vertical resize +2<CR>", {desc = "Increase window width"})
vim.keymap.set("n","<C-Left>",":vertical resize -2<CR>",{desc = "Decrease window width"})

-- Expands the word under cursor in IncRename command
-- vim.keymap.set("n", "<leader>rn", function()
--   return ":IncRename " .. vim.fn.expand("<cword>")
-- end, { expr = true })
-- vim.keymap.set("n", "<leader>rn", ":IncRename ")
