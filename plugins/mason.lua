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
        "luau_lsp",      -- Lua/Luau
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
      
      -- Automatically setup LSP servers installed via Mason
      handlers = {
        -- Default handler for all servers
        function(server_name)
          vim.lsp.enable(server_name)
        end,
        
        -- Custom handler for luau_lsp
        ["luau_lsp"] = function()
          vim.lsp.config.luau_lsp = {
            settings = {
              luau = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          }
          vim.lsp.enable("luau_lsp")
        end,

        -- Custom handler for pyright
        ["pyright"] = function()
          vim.lsp.config.pyright = {
            settings = {
              python = {
                analysis = {
                  typeCheckingMode = "basic",
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                },
              },
            },
          }
          vim.lsp.enable("pyright")
        end,

        -- Custom handler for gopls
        ["gopls"] = function()
          vim.lsp.config.gopls = {
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
              },
            },
          }
          vim.lsp.enable("gopls")
        end,

        -- Custom handler for rust_analyzer
        ["rust_analyzer"] = function()
          vim.lsp.config.rust_analyzer = {
            settings = {
              ["rust-analyzer"] = {
                cargo = {
                  allFeatures = true,
                },
              },
            },
          }
          vim.lsp.enable("rust_analyzer")
        end,

        -- Custom handler for yamlls
        ["yamlls"] = function()
          vim.lsp.config.yamlls = {
            settings = {
              yaml = {
                schemas = {
                  ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                  ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
                  kubernetes = "/*.yaml",
                },
                format = {
                  enable = true,
                },
              },
            },
          }
          vim.lsp.enable("yamlls")
        end,

        -- Custom handler for ts_ls
        ["ts_ls"] = function()
          vim.lsp.config.ts_ls = {
            settings = {
              typescript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
              javascript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
            },
          }
          vim.lsp.enable("ts_ls")
        end,
      },
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier",    -- Formatter
        "stylua",      -- Lua formatter
        "black",       -- Python formatter
        "isort",       -- Python import formatter
        "gofumpt",       -- Go formatter
        "goimports",   -- Go imports
        "rustfmt",     -- Rust formatter
        "eslint_d",    -- JS linter
        "pylint",      -- Python linter
      },
    })
  end,
}
