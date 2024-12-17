# Introduction

This is my (work in progress) configuration for using Neovim as an IDE for C/C++ and embedded development.

# Plugin Manager

I use [lazy.nvim](https://github.com/folke/lazy.nvim) for installing and managing plugins. The Lazy plugin manager and all plugins are installed under `~/.local/share/nvim/lazy`.

On startup, Lazy reads the files contained within the `lua/plugins` directory. Each of these files is known as a [plugin spec](https://lazy.folke.io/spec). Each plugin spec is expected to return a Lua table, which gives Lazy the information necessary to manage the plugin. Typically, each plugin will tell you the information that needs to be placed in the plugin spec.

# Syntax Highlighting and Treesitter


