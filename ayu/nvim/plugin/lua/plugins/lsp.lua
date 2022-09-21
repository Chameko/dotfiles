require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "rust_analyzer",
        "clangd",
        "taplo"
    }
})
require("lspconfig").clangd.setup({})
