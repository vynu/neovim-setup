return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            -- macOS: Cmd+k and Cmd+j also work
            ["<D-k>"] = actions.move_selection_previous,
            ["<D-j>"] = actions.move_selection_next,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          -- macOS: Show hidden files by default
          hidden = true,
          -- Ignore .git and other unnecessary directories
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    })

    telescope.load_extension("fzf")

    -- Keymaps (macOS friendly with both Ctrl and Cmd options)
    local keymap = vim.keymap
    
    -- Find files
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
    keymap.set("n", "<D-p>", "<cmd>Telescope find_files<cr>", { desc = "Find files (Cmd+P)" })
    
    -- Find text/grep
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find text" })
    keymap.set("n", "<D-f>", "<cmd>Telescope live_grep<cr>", { desc = "Find text (Cmd+F)" })
    
    -- Find buffers
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
    keymap.set("n", "<D-b>", "<cmd>Telescope buffers<cr>", { desc = "Find buffers (Cmd+B)" })
    
    -- Find help
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help" })
    
    -- Find recent files
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
    keymap.set("n", "<D-e>", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files (Cmd+E)" })
    
    -- Find git files
    keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
    keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
  end,
}
