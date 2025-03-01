-- Telescope plugin

local spec = {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },

  -- This function is called after the plugin is loaded
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require('telescope.builtin')

    telescope.setup({
      defaults = {
        -- Most of these are the defaults, I'm just explicitly listing
        --  them here for easy access.
        -- See: https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
        mappings = {
          i = {
            ["<CR>"] = actions.select_default,
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<Tab>"] = actions.toggle_selection,
            ["<S-Tab>"] = actions.toggle_selection,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<C-q>"] = actions.send_selected_to_qflist,
            ["<C-c>"] = actions.close,

            ["<C-/>"] = actions.which_key
          },

          n = {
            ["<CR>"] = actions.select_default,
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,

            ["<Tab>"] = actions.toggle_selection,
            ["<S-Tab>"] = actions.toggle_selection,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<C-q>"] = actions.send_selected_to_qflist,
            ["<C-c>"] = actions.close,

            ["?"] = actions.which_key
          }
        }
      }
    })

    -- Search for files under cwd (respects .gitignore)
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    -- Search for a string in the file under cwd (respects .gitignore)
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    -- Search open buffers, open selected buffer on <return>
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    -- Search help tags, open selected help info on <return>
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    -- Fuzzy search for a string in the current buffer
    vim.keymap.set('n', '<leader>fs', builtin.current_buffer_fuzzy_find, { desc = 'Telescope current buffer fuzzy find' })

    -- For ex commands
    vim.keymap.set('n', '<leader>fcc', builtin.commands, { desc = 'Telescope available commands' })
    vim.keymap.set('n', '<leader>fch', builtin.command_history, { desc = 'Telescope command history' })

    -- Sure why not
    vim.keymap.set('n', '<leader>fp', function() builtin.planets( {show_pluto = true, show_moon = true }) end, { desc = 'Telescope find planets' })

    vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = 'Telescope quickfix list' })

    vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = 'Telescope man pages' })
  end
}

return spec
