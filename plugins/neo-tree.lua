return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- Ensure icons are loaded
    require("nvim-web-devicons").setup({
      override = {},
      default = true,
    })

    -- FORCE Nerd Font icons (remove fallback detection)
    local icons = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      folder_empty_open = "",
      default = "",
      expander_collapsed = "",
      expander_expanded = "",
      git = {
        added = "",
        modified = "",
        deleted = "✖",
        renamed = "󰁕",
        untracked = "",
        ignored = "",
        unstaged = "󰄱",
        staged = "",
        conflict = "",
      },
    }

    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          with_expanders = true,
          expander_collapsed = icons.expander_collapsed,
          expander_expanded = icons.expander_expanded,
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = icons.folder_closed,
          folder_open = icons.folder_open,
          folder_empty = icons.folder_empty,
          folder_empty_open = icons.folder_empty_open,
          default = icons.default,
          highlight = "NeoTreeFileIcon",
        },
        modified = {
          symbol = "[+]",
          highlight = "NeoTreeModified",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName",
        },
        git_status = {
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            deleted = icons.git.deleted,
            renamed = icons.git.renamed,
            untracked = icons.git.untracked,
            ignored = icons.git.ignored,
            unstaged = icons.git.unstaged,
            staged = icons.git.staged,
            conflict = icons.git.conflict,
          },
        },
      },
      
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            ".git",
            ".DS_Store",
            "thumbs.db",
            "node_modules",
          },
          never_show = {
            ".DS_Store",
          },
        },
      },
      
      window = {
        position = "left",
        width = 35,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["<space>"] = "none",
          ["<cr>"] = "open",
          ["<esc>"] = "cancel",
          ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
          ["l"] = "open",
          ["h"] = "close_node",
          ["z"] = "close_all_nodes",
          ["Z"] = "expand_all_nodes",
          ["a"] = {
            "add",
            config = {
              show_path = "none",
            },
          },
          ["A"] = "add_directory",
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy",
          ["m"] = "move",
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
          ["i"] = "show_file_details",
        },
      },
    })

    -- Auto-open neo-tree on startup (only if no file specified)
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if vim.fn.argc() == 0 then
          vim.cmd("Neotree show")
        end
      end,
    })

    -- KEYMAPS FOR NEO-TREE AND WINDOW NAVIGATION
    local keymap = vim.keymap

    -- Toggle Neo-tree
    keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree", silent = true })
    keymap.set("n", "<D-1>", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree (Cmd+1)", silent = true })

    -- Focus Neo-tree (open if closed, focus if open)
    keymap.set("n", "<leader>o", ":Neotree focus<CR>", { desc = "Focus Neo-tree", silent = true })

    -- Reveal current file in Neo-tree
    keymap.set("n", "<leader>r", ":Neotree reveal<CR>", { desc = "Reveal in Neo-tree", silent = true })
    keymap.set("n", "<D-r>", ":Neotree reveal<CR>", { desc = "Reveal in Neo-tree (Cmd+R)", silent = true })

    -- WINDOW NAVIGATION - Switch between Neo-tree and Editor
    -- Ctrl+h: Focus Neo-tree window (left)
    keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus left window (Neo-tree)", silent = true })
    
    -- Ctrl+l: Focus editor window (right)
    keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus right window (Editor)", silent = true })
    
    -- Ctrl+j: Focus window below
    keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus window below", silent = true })
    
    -- Ctrl+k: Focus window above
    keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus window above", silent = true })

    -- macOS alternatives with Cmd key
    keymap.set("n", "<D-h>", "<C-w>h", { desc = "Focus left window (Cmd+H)", silent = true })
    keymap.set("n", "<D-l>", "<C-w>l", { desc = "Focus right window (Cmd+L)", silent = true })

    -- Window resizing
    keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width", silent = true })
    keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase width", silent = true })
    keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrease height", silent = true })
    keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase height", silent = true })

    -- Quick window switching (alternate between last two windows)
    keymap.set("n", "<leader><leader>", "<C-w>w", { desc = "Switch to other window", silent = true })
  end,
}
