local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
    "folke/which-key.nvim",
    { "folke/neoconf.nvim",              cmd = "Neoconf" },
    "folke/neodev.nvim",
    "xiyaowong/transparent.nvim",
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    "nvim-telescope/telescope-fzf-native.nvim",
    "kyazdani42/nvim-tree.lua",
    'folke/tokyonight.nvim',
    { "catppuccin/nvim", name = "catppuccin" },
    { 'nvim-treesitter/nvim-treesitter', cmd = "TSUpdate" },
    'nvim-treesitter/playground',
    'theprimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    },
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    "BurntSushi/ripgrep",
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
    {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
            require('neoscroll').setup({
                -- All these keys will be mapped to their corresponding default scrolling animation
                mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
                    '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
                hide_cursor = true,          -- Hide cursor while scrolling
                stop_eof = true,             -- Stop at <EOF> when scrolling downwards
                use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
                respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
                cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
                easing_function = nil,       -- Default easing function
                pre_hook = nil,              -- Function to run before the scrolling animation starts
                post_hook = nil,             -- Function to run after the scrolling animation ends
            })
        end
    },
    {
        'wuelnerdotexe/vim-astro',
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function() require "lsp_signature".on_attach() end,
    },
    {
        'hrsh7th/cmp-nvim-lsp-signature-help'
    },
    -- {
    --     config = function()
    --         require 'lspconfig'.setup({
    --             require 'jdtls'.setup {
    --                 cmd = {
    --                     "-xx:+useparallelgc",
    --                     "-xx:gctimeratio=4",
    --                     "-xx:adaptivesizepolicyweight=90",
    --                     "-dsun.zip.disablememorymapping=true",
    --                     "-djava.import.generatesmetadatafilesatprojectroot=false",
    --                     "-xmx1g",
    --                     "-xms100m",
    --                     "-javaagent:~/.local/share/nvim/mason/packages/jdtls/lombok.jar",
    --                     "-jar $(echo $jar) /"
    --                     -- "-jar $(echo "$jar") ",
    --                 },
    --                 use_lombok_agent = true
    --             }
    --         })
    --     end
    -- },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "p00f/nvim-ts-rainbow",
    },
    {
        "numToStr/Comment.nvim",
    },
    {
        'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
        end
    },
    'nvim-lualine/lualine.nvim',
    'nvim-tree/nvim-web-devicons',
    'windwp/nvim-autopairs'
}

local opts = {}

require("lazy").setup(plugins, opts)
require("mason").setup()
require('lualine').get_config()
require('lualine').setup({
    options = {
        theme = 'ayu_mirage',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' }
    }
})

require("nvim-autopairs").setup();


require('Comment').setup({
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = 'gc',
        ---Block-comment keymap
        block = 'gb',
    },
    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil,
})
