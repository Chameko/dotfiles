local g = vim.g
local og = vim.o
local w = vim.wo
local map = vim.keymap.set

-- Commands
vim.cmd [[set termguicolors]]

-- global options
og.guifont = "FiraCode Nerd Font:h9"  -- Set font size
og.linebreak = true -- Wrap long lines
og.breakindent = true -- Keep wraped lines indented
og.showbreak = "﬌ " -- Symbol for line wraps
og.expandtab = true -- Use spaces not tabs
og.tabstop = 4 -- Set tab display width
og.softtabstop = 4 -- Soft tabs are 4 as well
og.shiftwidth = 4 -- Shift 4 spaces by default
og.smartindent = true -- Enable smart indent
og.number = true -- Numbered lines
og.rnu = true -- Relative numbered lines
w.list = true -- Render whitespace
w.cursorline = true -- Enable cursor line
og.lcs = "space:·,tab:-,eol:¬" -- Characters for whitespace
og.timeoutlen = 250 -- Timeout for which key
og.mouse = "nvi" -- Enable mouse

-- Mappings
g.mapleader = ';'
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>") -- Hover info
map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>") -- Rename something
map("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>") -- Code action
map("n", "<C-\\>", "<cmd>ToggleTerm<cr>") -- Toggle terminal
map("t", "<Esc>", "<C-\\><C-N>")
-- Which key
local wk = require("which-key")

-- General register
wk.register({
    g = {
        d = {"<cmd>lua vim.lsp.buf.definition()<cr>", "Goto definition"},
    },
    ["[d"] = {"<cmd>lua vim.diagnostic.goto_prev()<cr>", "Move to previous diagnostic"},
    ["]d"] = {"<cmd>lua vim.diagnostic.goto_next()<cr>", "Move to next diagnostic"},
})

wk.register({
    -- buffers
    b = {
        name = "buffer",
        b = {"<C-^>", "Toggle between current and last buffer"},
        n = {"<cmd>bn<cr>", "Next buffer"},
        p = {"<cmd>bp<cr>", "Previous buffer"},
        d = {"<cmd>bd<cr>", "Delete buffer"},
        k = {"<cmd>bk<cr>", "Kill buffer"},
        l = {"<cmd>Telescope buffers<cr>", "List buffers"},
        h = {"<cmd>new<cr>", "New horizontal buffer"},
        v = {"<cmd>vnew<cr>", "New vertical buffer"},
    },
    f = {
        name = "find",
        f = {"<cmd>Telescope find_files<cr>", "Find file"},
    },
    l = {
        name = "lsp",
        s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document symbols"},
        w = {"<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace symbols"},
        d = {"<cmd>Telescope lsp_definitions<cr>", "Defenition"},
        r = {"<cmd>Telescope lsp_references<cr>", "References"},
        i = {"<cmd>Telescope lsp_implementations<cr>", "Implementations"},
        c = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action"}
    },
    d = {"<cmd>Telescope diagnostics<cr>", "Diagnostics"},
    t = {"<cmd>NvimTreeToggle<cr>", "Toggle file tree"}
}, { prefix = "<leader>" })
