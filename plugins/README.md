Install formatters

After restarting Neovim, install formatters with:

vim:Mason
Then install these formatters:


prettier (JS/TS/CSS/HTML/JSON)

stylua (Lua)

black and isort (Python)

gofmt and goimports (Go)

rustfmt (Rust)

shfmt (Shell scripts)


Quick Setup

Add these three files to your plugins/ directory

Restart Neovim (:q then nvim)

Let lazy.nvim install plugins

Run :Mason and install formatters you need

Open a file and it will auto-format on save!


Manual formatting shortcut: <leader>mp (or whatever your leader key is + mp)

This setup gives you:


✅ Auto-format on save

✅ Syntax highlighting for all major languages

✅ Proper file type detection

✅ Easy formatter management via Mason
