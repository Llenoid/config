
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end

-- Basic settings
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = false -- set relative numbered lines
vim.opt.cursorline = true -- highlight the current line
vim.opt.wrap = false -- display lines as one long line
vim.opt.scrolloff = 10 -- scrolloff 10 lines from bottom/top
vim.opt.sidescrolloff = 8 --scrolloff 8 lines from right
vim.opt.textwidth = 120 -- line length

-- Indentation
vim.opt.softtabstop = 1 -- softtabstop
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.autoindent = true -- copy indent from current line
vim.opt.breakindent = true -- Enable break indent

-- Search settings
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- Case                             -insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.incsearch = true -- show matches as you type
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!

-- Visual settings
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
-- vim.opt.colorcolumn = "120"                            -- show column on 120
vim.opt.showmatch = true -- showmatch
vim.opt.matchtime = 2 -- showmatch time
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.completeopt = "menu,menuone,noinsert,noselect" -- mostly just for cmp
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.pumblend = 10 -- pumblend
vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.concealcursor = "" -- Don't hide cursorline markup
vim.opt.synmaxcol = 300 -- syntax highlighting limit
vim.opt.laststatus = 3 -- :h laststatus
vim.opt.showcmd = false -- Show (partial) command in the last line of the screen
vim.opt.ruler = true -- show position of cursor x,y

-- File handling
vim.opt.backup = false -- creates a backup file
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.swapfile = false -- creates a swapfile
vim.opt.undofile = true -- Save undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- undo directory
vim.opt.updatetime = 250 -- faster completion (4000ms default)
vim.opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.ttimeoutlen = 0 -- Key code timeout
vim.opt.autoread = true -- autoreload files changed outside vim
vim.opt.autowrite = false -- don't autosave

-- Behaviour settings
vim.opt.hidden = true -- Allow hidden buffers
vim.opt.errorbells = false -- no errorbells
vim.opt.backspace = "indent,eol,start" -- backspace behaviour
vim.opt.autochdir = false -- false: Don't autochange the directory
vim.opt.path:append("**") -- include subdirectories in search
vim.opt.selection = "exclusive" -- Selection behaviour
vim.opt.mouse = "a" -- enable mouse
vim.opt.modifiable = true -- allow buffer modifications
vim.opt.encoding = "utf-8" -- set encoding
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.iskeyword:append("-") -- treat dash as part of word
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.shortmess:append("c") -- This option helps to avoid all the |hit-enter| prompts caused by file messages, for example with CTRL-G, and to avoid some other messages.

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Cursor
vim.opt.guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- custom
vim.o.virtualedit = "onemore"
vim.g.gitblame_enabled = 0
vim.g.disable_tscontext = true
vim.g.disable_autoformat = true
vim.g.python3_host_prog = vim.fn.expand("~/.config/nvim/venv/nvim_host/bin/python")
vim.g.markdown_disabled = true
vim.g.autoformat = false
vim.g.gitblame_display_virtual_text = 0

-- Set c as language for header files
vim.g.c_syntax_for_h = 1

-- Vim diff
vim.o.diffopt = 'internal,filler,closeoff,algorithm:patience,indent-heuristic,inline:char,linematch:40'

-- disable netrw to prevent flickering
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tarPlugin = 1
