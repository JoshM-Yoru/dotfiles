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
call plug#begin()
Plug 'junegunn/vim-plug'
Plug 'Yggdroot/indentLine'
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/lifepillar/pgsql.vim' " PSQL Pluging needs :SQLSetType pgsql.vim
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/neoclide/coc.nvim', { 'branch': 'release'} " Auto Completion
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple
Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'sharkdp/fd'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'ThePrimeagen/harpoon'
Plug 'mhartington/formatter.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'psliwka/vim-smoothie'
Plug 'preservim/nerdcommenter'
Plug 'elvessousa/sobrio'
Plug 'rktjmp/lush.nvim'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'windwp/nvim-autopairs'
Plug 'mattn/emmet-vim'
Plug 'Mofiqul/dracula.nvim'
Plug 'github/copilot.vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'windwp/nvim-ts-autotag'
Plug 'sharkdp/fd'
Plug 'wuelnerdotexe/vim-astro'
Plug 'ChiliConSql/neovim-stylus'
Plug 'puremourning/vimspector'
Plug 'artur-shaik/jc.nvim'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'startup-nvim/startup.nvim'
Plug 'tpope/vim-fugitive'
Plug 'ggandor/leap.nvim'
Plug 'tpope/vim-repeat'
Plug 'mfussenegger/nvim-dap'

" LSP client and AutoInstaller
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'mfussenegger/nvim-jdtls'
" Plug 'hrsh7th/nvim-cmp' 
" Plug 'hrsh7th/cmp-nvim-lsp'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter'

call plug#end()


nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>
nmap <F8> :TagbarToggle<CR>
:set completeopt-=preview " For No Previews
:set termguicolors
:colorscheme dracula
:set background=dark
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
highlight Normal ctermbg=NONE guibg=NONE
" airline symbols

    " powerline symbols
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.maxlinenr = ''

" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
filetype plugin on
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
autocmd BufRead,BufEnter *.astro set filetype=astro
autocmd FileType apache setlocal commentstring=#\ %s
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>lg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
let g:astro_typescript = 'enable'
let g:astro_stylus = 'enable'
]])


require'nvim-treesitter.configs'.setup {
		context_commentstring = {
				enable = true,
				config = {
					javascript = {
						__default = '// %s',
						jsx_element = '{/* %s */}',
						jsx_fragment = '{/* %s */}',
						jsx_attribute = '// %s',
						comment = '// %s'
					}
				}
		},
		autotag = {
				enable = true,
  }
}

local filetypes = {
    'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript',
    'xml',
    'php',
    'markdown',
    'glimmer','handlebars','hbs'
}
local skip_tags = {
  'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'slot',
  'input', 'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr','menuitem'
}

local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})

local ts_conds = require('nvim-autopairs.ts-conds')


-- press % => %% only while inside a comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})

npairs.setup({ map_cr = true })

require('jc').setup{}

require('startup').setup({theme="dashboard"})

require('leap').add_default_mappings()
