local M = {
    'nvim-flutter/flutter-tools.nvim',
    lazy = true,
    cmd = "FlutterRun",
    ft = "dart",
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
}

return M
