vim.cmd([[
:set number
:set autoindent
:set tabstop=2
:set shiftwidth=4
:set smarttab
:set softtabstop=2
:set mouse=a
:set number relativenumber
:set nu rnu
nmap <F8> :TagbarToggle<CR>

nnoremap <C-u> <C-u> zz
nnoremap <C-d> <C-d> zz
nnoremap n nzz

let g:astro_typescript = 'enable'
let g:astro_stylus = 'enable'

" :let $JAVA_TOOL_OPTIONS = '-javaagent:~/Programming/Java/Lombok/lombok.jar -Xbootclasspath/p:~/Programming/Java/Lombok/lombok.jar -jar:$(echo "$JAR")'

":set command SpringProject !cp -r ~/Programming/Java/SpringBoot/spring .
":set command JClass r ~/Programming/Java/Snippets/Class.txt
":set command JEnum r ~/Programming/Java/Snippets/Enum.txt.txt
":set command JAbstract r ~/Programming/Java/Snippets/Abstract.txt
":set command JInterface r ~/Programming/Java/Snippets/Interface.txt

" :command SpringProject !cp -R ~/Programming/Java/SpringBoot/spring/  .

]])

local java = { "clang-format", "uncrustify" }
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })
--
--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight"
-- lvim.colorscheme = "dracula"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- transparency
lvim.transparent_window = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
vim.opt.showtabline = 0
lvim.builtin.bufferline.active = false
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Lualine Styling
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.sections.lualine_c = { "diff" }
-- lvim.builtin.lualine.options.theme = "horizon".options.theme = "horizon"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "java",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "java",
    "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.ensure_installed = {
    "java",
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
    -- {
    --   "folke/trouble.nvim",
    --   cmd = "TroubleToggle",
    -- },
    {
        "Mofiqul/dracula.nvim"
    },
    {
        'artanikin/vim-synthwave84'
    },
    {
        'flazz/vim-colorschemes'
    },
    {
        "ggandor/leap.nvim",
        event = "BufRead",
        config = function()
            require('leap').add_default_mappings()
        end,
    },
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
        "rktjmp/lush.nvim",
    },
    -- { "zbirenbaum/copilot.lua",
    --     event = "InsertEnter",
    --     config = function()
    --         vim.schedule(function()
    --             require("copilot").setup()
    --         end)
    --     end,
    -- },

    -- { "zbirenbaum/copilot-cmp",
    --     after = { "copilot.lua", "nvim-cmp" },
    -- },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function() require "lsp_signature".on_attach() end,
    },
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
        "kevinhwang91/rnvimr",
        cmd = "RnvimrToggle",
        config = function()
            vim.g.rnvimr_draw_border = 1
            vim.g.rnvimr_pick_enable = 1
            vim.g.rnvimr_bw_enable = 1
        end,
    },
    { "tpope/vim-repeat" },
    {
        "turbio/bracey.vim",
        cmd = { "Bracey", "BracyStop", "BraceyReload", "BraceyEval" },
        run = "npm install --prefix server",
    },
    {
        'tpope/vim-dadbod',
    },
    {
        'kristijanhusak/vim-dadbod-ui',
    },
    {
        'wuelnerdotexe/vim-astro',
    },
    -- {
    --     'mfussenegger/nvim-jdtls',
    -- },
    {
        'hrsh7th/cmp-nvim-lsp-signature-help'
    },
    {
        config = function()
            require 'lspconfig'.setup({
                require 'jdtls'.setup {
                    cmd = {
                        "-XX:+UseParallelGC",
                        "-XX:GCTimeRatio=4",
                        "-XX:AdaptiveSizePolicyWeight=90",
                        "-Dsun.zip.disableMemoryMapping=true",
                        "-Djava.import.generatesMetadataFilesAtProjectRoot=false",
                        "-Xmx1G",
                        "-Xms100m",
                        "-javaagent:~/.local/share/nvim/mason/packages/jdtls/lombok.jar",
                        "-jar $(echo $JAR) /"
                        -- "-jar $(echo "$JAR") ",
                    },
                    use_lombok_agent = true
                }
            })
        end
    },
    -- {
    --     'prettier/vim-prettier'
    -- },
    -- {
    --     'rose-pine/neovim',
    --     name = 'rose-pine',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("rose-pine").setup()
    --         vim.cmd('colorscheme rose-pine')
    --     end
    -- }
    -- {
    --     "aca/emmet-ls",
    --     config = function()
    --         local lspconfig = require("lspconfig")
    --         local configs = require("lspconfig/configs")

    --         local capabilities = vim.lsp.protocol.make_client_capabilities()
    --         capabilities.textDocument.completion.completionItem.snippetSupport = true
    --         capabilities.textDocument.completion.completionItem.resolveSupport = {
    --             properties = {
    --                 "documentation",
    --                 "detail",
    --                 "additionalTextEdits",
    --             },
    --         }

    --         if not lspconfig.emmet_ls then
    --             configs.emmet_ls = {
    --                 default_config = {
    --                     cmd = { "emmet-ls", "--stdio" },
    --                     filetypes = {
    --                         "html",
    --                         "css",
    --                         "javascript",
    --                         "typescript",
    --                         "eruby",
    --                         "typescriptreact",
    --                         "javascriptreact",
    --                         "svelte",
    --                         "vue",
    --                         "astro",
    --                     },
    --                     root_dir = function(fname)
    --                         return vim.loop.cwd()
    --                     end,
    --                     settings = {},
    --                 },
    --             }
    --         end
    --         lspconfig.emmet_ls.setup({ capabilities = capabilities })
    --     end,
    -- },
    -- {
    --     'akinsho/git-conflict',
    --     config = function() require('git-conflict').setup()
    --     end,
    --     {
    --         default_mappings = true, -- disable buffer local mapping created by this plugin
    --         default_commands = true, -- disable commands created by this plugin
    --         disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
    --         highlights = { -- They must have background color, otherwise the default color will be used
    --             incoming = 'DiffText',
    --             current = 'DiffAdd',
    --         },
    --     }
    -- }
    -- {
    --     'tamton-aquib/duck.nvim',
    --     config = function()
    --         vim.keymap.set('n', '<leader>kk', function() require("duck").hatch() end, {})
    --         vim.keymap.set('n', '<leader>dk', function() require("duck").cook() end, {})
    --     end
    -- }
    -- {
    --   'artur-shaik/jc.nvim',
    -- },
}
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
