local spec =  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        -- Watch for external filesystem changes to auto-reload oil
        watch_for_changes = true,
        columns = {
            "icon",
            "permissions",
            "size",
            "mtime"
        },
        -- Send deleted items to trash instead of permanent deletion
        delete_to_trash = true
    },
    -- Optional dependencies
    dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,

    config = function(_, opts)
        require("oil").setup(opts)
        vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Oil open parent directory" })

        -- Open most recently opened directory
        -- https://github.com/stevearc/oil.nvim/issues/437#issuecomment-2207801331
        local last_directory = nil
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "oil://*",
            callback = function(_) last_directory = require("oil").get_current_dir() end,
        })
        vim.keymap.set("n", "<leader>-",
            function()
                if last_directory then
                    require("oil").open(last_directory)
                else
                    vim.notify("No previous directory to open", vim.log.levels.WARN)
                end
            end,
            { desc = "Oil open last directory" }
        )
    end
}

return spec
