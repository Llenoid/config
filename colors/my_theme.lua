local colors = {
    bg      = "#1f1f1f",
    fg      = "#cccccc",
    line_nr = "#6e7681",
    cursor_line = "#282828",
    selection   = "#264f78",
    comment     = "#6A9955",
    keyword     = "#569CD6", -- Blue
    control     = "#C586C0", -- Pink/Purple
    type        = "#4EC9B0", -- Teal
    func        = "#DCDCAA", -- Yellow
    string      = "#CE9178", -- Orange/Red
    number      = "#B5CEA8", -- Light Green
    variable    = "#9CDCFE", -- Light Blue
    constant    = "#4FC1FF", -- Cyan
    tag         = "#569CD6",
    error       = "#f85149",
    warning     = "#cca700",
    info        = "#3794ff",
    hint        = "#eeeeb3",
    border      = "#454545",
}

local groups = {
    -- Base
    Normal          = { fg = colors.fg, bg = colors.bg },
    CursorLine      = { bg = colors.cursor_line },
    CursorLineNr    = { fg = colors.fg, bold = true },
    LineNr          = { fg = colors.line_nr },
    Search          = { fg = "NONE", bg = "#9e6a03" },
    Visual          = { bg = colors.selection },
    ColorColumn     = { bg = "#2b2b2b" },
    VertSplit       = { fg = colors.border },
    WinSeparator    = { fg = colors.border },
    Pmenu           = { bg = "#1f1f1f", fg = colors.fg },
    PmenuSel        = { bg = "#0078d4", fg = "#ffffff" },
    
    -- Syntax
    Comment         = { fg = colors.comment, italic = true },
    Constant        = { fg = colors.constant },
    String          = { fg = colors.string },
    Character       = { fg = colors.string },
    Number          = { fg = colors.number },
    Boolean         = { fg = colors.keyword },
    Float           = { fg = colors.number },
    Identifier      = { fg = colors.variable },
    Function        = { fg = colors.func },
    Statement       = { fg = colors.control },
    Conditional     = { fg = colors.control },
    Repeat          = { fg = colors.control },
    Label           = { fg = colors.control },
    Operator        = { fg = colors.fg },
    Keyword         = { fg = colors.keyword, italic = true },
    Exception       = { fg = colors.control },
    PreProc         = { fg = colors.keyword },
    Type            = { fg = colors.type },
    StorageClass    = { fg = colors.keyword },
    Structure       = { fg = colors.type },
    Special         = { fg = colors.func },
    Underlined      = { underline = true },
    Error           = { fg = colors.error },
    Todo            = { fg = colors.bg, bg = colors.func, bold = true },

    -- Treesitter (Modern Neovim)
    ["@variable"]           = { fg = colors.variable },
    ["@variable.builtin"]   = { fg = colors.keyword },
    ["@function"]           = { fg = colors.func },
    ["@function.builtin"]   = { fg = colors.func },
    ["@keyword"]            = { fg = colors.keyword, italic = true },
    ["@keyword.function"]   = { fg = colors.keyword },
    ["@keyword.return"]     = { fg = colors.control },
    ["@keyword.operator"]   = { fg = colors.control },
    ["@property"]           = { fg = colors.variable },
    ["@field"]              = { fg = colors.variable },
    ["@type"]               = { fg = colors.type },
    ["@type.builtin"]       = { fg = colors.type },
    ["@parameter"]          = { fg = colors.variable },
    ["@string"]             = { fg = colors.string },
    ["@number"]             = { fg = colors.number },
    ["@constant"]           = { fg = colors.constant },
    ["@punctuation.bracket"] = { fg = colors.fg },
    ["@tag"]                = { fg = colors.tag },
    ["@tag.attribute"]      = { fg = colors.variable, italic = true },

    -- LSP / Diagnostics
    DiagnosticError = { fg = colors.error },
    DiagnosticWarn  = { fg = colors.warning },
    DiagnosticInfo  = { fg = colors.info },
    DiagnosticHint  = { fg = colors.hint },
    DiagnosticUnderlineError = { undercurl = true, sp = colors.error },
}

-- Apply the theme
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "vscode_generated"

for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
end
