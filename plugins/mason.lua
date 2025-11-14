return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",        -- Lua
        "ts_ls",         -- TypeScript/JavaScript
        "pyright",       -- Python
        "gopls",         -- Go
        "rust_analyzer", -- Rust
        "yamlls",        -- YAML
        "jsonls",        -- JSON
        "html",          -- HTML
        "cssls",         -- CSS
        "tailwindcss",   -- Tailwind
      },
      automatic_installation = true,
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier",    -- Formatter
        "stylua",      -- Lua formatter
        "black",       -- Python formatter
        "isort",       -- Python import formatter
        "gofmt",       -- Go formatter
        "goimports",   -- Go imports
        "rustfmt",     -- Rust formatter
        "eslint_d",    -- JS linter
        "pylint",      -- Python linter
      },
    })
  end,
}
