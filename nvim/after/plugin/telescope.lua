local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>sg', builtin.git_files, {})
vim.keymap.set('n', '<leader>st', builtin.live_grep, {})

if vim.fn.isdirectory(vim.v.argv[2]) == 1 then
    vim.api.nvim_set_current_dir(vim.v.argv[2])
end

local telescope = require('telescope')

telescope.setup {

    pickers = {
        find_files = {

            hidden = true

        }
    }
}
