-- -- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
-- local fn = vim.fn
-- local project_name = fn.fnamemodify(fn.getcwd(), ':p:h:t')

-- local home_dir = os.getenv('HOME')
-- local jabba_jdk_dir = "/usr/local/java/jdk-17/"
-- local jdk8_dir = jabba_jdk_dir .. '1.8.0/Contents/Home'
-- local nvim_dir = home_dir .. '/.config/nvim'
-- local rule_dir = nvim_dir .. '/rule/'
-- local java_settings_url = rule_dir .. 'settings.prefs'
-- local java_format_style_rule = rule_dir .. 'eclipse-java-google-style.xml'
-- local java_debug_jar = fn.stdpath('data') .. '/mason/packages/java-debug-adapter/extension/server/*.jar'
-- local workspace_root_dir = nvim_dir .. '/workspace/'
-- local workspace_dir = workspace_root_dir .. project_name
-- local lsp = require('plugins.lsp')

-- local on_attach = function(client, bufnr)
--     lsp.on_attach(client, bufnr)
--     lsp.navic_attach_and_setup(client, bufnr)

--     -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
--     -- you make during a debug session immediately.
--     -- Remove the option if you do not want that.
--     require("jdtls").setup_dap({ hotcodereplace = "auto" })
--     require("jdtls.setup").add_commands()
--     require("jdtls.dap").setup_dap_main_class_configs()
-- end

-- local is_file_exist = function(path)
--     local f = io.open(path, 'r')
--     return f ~= nil and io.close(f)
-- end

-- local get_lombok_javaagent = function()
--     local lombok_dir = home_dir .. '/.m2/repository/org/projectlombok/lombok/'
--     local lombok_versions = io.popen('ls -1 "' .. lombok_dir .. '" | sort -r')
--     if lombok_versions ~= nil then
--         local lb_i, lb_versions = 0, {}
--         for lb_version in lombok_versions:lines() do
--             lb_i = lb_i + 1
--             lb_versions[lb_i] = lb_version
--         end
--         lombok_versions:close()
--         if next(lb_versions) ~= nil then
--             local lombok_jar = fn.expand(string.format('%s%s/*.jar', lombok_dir, lb_versions[1]))
--             if is_file_exist(lombok_jar) then
--                 return string.format('--jvm-arg=-javaagent:%s', lombok_jar)
--             end
--         end
--     end
--     return ''
-- end

-- local get_java_debug_jar = function()
--     local jdj_full_path = fn.expand(java_debug_jar)
--     if is_file_exist(jdj_full_path) then
--         return jdj_full_path
--     end
--     return ''
-- end

-- local get_cmd = function()
--     local cmd = {

--         -- 💀
--         'jdtls',
--     }

--     local lombok_javaagent = get_lombok_javaagent()
--     if (lombok_javaagent ~= '') then
--         table.insert(cmd, lombok_javaagent)
--     end

--     -- 💀
--     -- See `data directory configuration` section in the README
--     table.insert(cmd, '-data')
--     table.insert(cmd, workspace_dir)

--     return cmd
-- end

-- -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
-- -- Watch out for the 💀, it indicates that you must adjust something.
-- local config = {
--     cmd = get_cmd(),
--     -- 💀
--     -- This is the default if not provided, you can remove it. Or adjust as needed.
--     -- One dedicated LSP server & client will be started per unique root_dir
--     root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),
--     -- Here you can configure eclipse.jdt.ls specific settings
--     -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--     -- for a list of options
--     settings = {
--         ['java.settings.url'] = java_settings_url,
--         java = {
--             configuration = {
--                 -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--                 -- And search for `interface RuntimeOption`
--                 -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
--                 runtimes = {
--                     {
--                         name = 'JavaSE-17',
--                         path = jabba_jdk_dir
--                     }
--                 }
--             },
--             codeGeneration = {
--                 hashCodeEquals = {
--                     useInstanceof = true,
--                     useJava7Objects = true
--                 },
--                 toString = {
--                     codeStyle = "STRING_BUILDER_CHAINED"
--                 },
--                 useBlocks = true,
--             },
--             contentProvider = { preferred = 'fernflower' },
--             implementationsCodeLens = {
--                 enabled = true
--             },
--             referencesCodeLens = {
--                 enabled = true
--             },
--             signatureHelp = { enabled = true },
--             sources = {
--                 organizeImports = {
--                     starThreshold = 9999,
--                     staticStarThreshold = 9999,
--                 }
--             },
--             format = {
--                 settings = {
--                     url = java_format_style_rule,
--                     profile = 'GoogleStyle'
--                 }
--             }
--         }
--     },
--     -- Language server `initializationOptions`
--     -- You need to extend the `bundles` with paths to jar files
--     -- if you want to use additional eclipse.jdt.ls plugins.
--     --
--     -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
--     --
--     -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
--     init_options = {
--         bundles = {
--             get_java_debug_jar()
--         }
--     },
--     capabilities = lsp.get_capabilities(),
--     flags = {
--         allow_incremental_sync = true,
--         debounce_text_changes = 150,
--         server_side_fuzzy_completion = true
--     },
--     ['on_attach'] = on_attach,
-- }
-- -- This starts a new client & server,
-- -- or attaches to an existing client & server depending on the `root_dir`.
-- require('jdtls').start_or_attach(config)
-- -- require('wlsample.airline')

-- local wk = require('which-key')
-- wk.register({
--     ['<A-CR>'] = {
--         '<Esc><Cmd>lua vim.lsp.buf.range_code_action()<CR>',
--         'Range code action'
--     },
--     c = {
--         rv = {
--             '<Esc><Cmd>lua require("jdtls").extract_variable(true)<CR>',
--             'Extract variable'
--         },
--         rc = {
--             '<Esc><Cmd>lua require("jdtls").extract_constant(true)<CR>',
--             'Extract constant'
--         },
--         rm = {
--             '<Esc><Cmd>lua require("jdtls").extract_method(true)<CR>',
--             'Extract method'
--         }
--     }
-- }, {
--     mode = 'v'
-- })

-- wk.register({
--     ['<A-o>'] = {
--         '<Cmd>lua require("jdtls").organize_imports()<CR>',
--         'Organize imports'
--     },
--     c = {
--         rv = {
--             '<Cmd>lua require("jdtls").extract_variable()<CR>',
--             'Extract variable'
--         },
--         rc = {
--             '<Cmd>lua require("jdtls").extract_constant()<CR>',
--             'Extract constant'
--         }
--     }
-- })
-- local config = {
--     cmd = { '/path/to/jdt-language-server/bin/jdtls' },
--     root_dir = vim.fs.dirname(vim.fs.find({ '.gradlew', '.git', 'mvnw' }, { upward = true })[1]),
-- }
-- require('jdtls').start_or_attach(config)

-- -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
-- local config = {
--     -- The command that starts the language server
--     -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--     cmd = {

--         -- 💀
--         '~/.sdkman/candidates/java/17.0.4-oracle', -- or '/path/to/java17_or_newer/bin/java'
--         -- depends on if `java` is in your $PATH env variable and if it points to the right version.

--         '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--         '-Dosgi.bundles.defaultStartLevel=4',
--         '-Declipse.product=org.eclipse.jdt.ls.core.product',
--         '-Dlog.protocol=true',
--         '-Dlog.level=ALL',
--         "-javaagent: ~/.local/share/nvim/mason/packages/jdtls/lombok.jar",
--         '-Xms1g',
--         '--add-modules=ALL-SYSTEM',
--         '--add-opens', 'java.base/java.util=ALL-UNNAMED',
--         '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

--         -- 💀
--         '-jar',
--         '~/Library/Java/jdt-language-server-1.9.0-202203031534/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
--         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
--         -- Must point to the                                                     Change this to
--         -- eclipse.jdt.ls installation                                           the actual version


--         -- 💀
--         '-configuration', '~/Library/Java/jdt-language-server-1.9.0-202203031534/config_linux',
--         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
--         -- Must point to the                      Change to one of `linux`, `win` or `mac`
--         -- eclipse.jdt.ls installation            Depending on your system.


--         -- 💀
--         -- See `data directory configuration` section in the README
--         '-data', '/path/to/unique/per/project/workspace/folder'
--     },

--     -- 💀
--     -- This is the default if not provided, you can remove it. Or adjust as needed.
--     -- One dedicated LSP server & client will be started per unique root_dir
--     root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),

--     -- Here you can configure eclipse.jdt.ls specific settings
--     -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--     -- for a list of options
--     settings = {
--         java = {
--         }
--     },

--     -- Language server `initializationOptions`
--     -- You need to extend the `bundles` with paths to jar files
--     -- if you want to use additional eclipse.jdt.ls plugins.
--     --
--     -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
--     --
--     -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
--     init_options = {
--         bundles = {}
--     },
-- }
-- -- This starts a new client & server,
-- -- or attaches to an existing client & server depending on the `root_dir`.
-- require('jdtls').start_or_attach(config)







-- vim.opt_local.shiftwidth = 2
-- vim.opt_local.tabstop = 2
-- vim.opt_local.cmdheight = 2 -- more space in the neovim command line for displaying messages

-- local capabilities = require("lvim.lsp").common_capabilities()

-- local status, jdtls = pcall(require, "jdtls")
-- if not status then
--     return
-- end

-- -- Determine OS
-- local home = os.getenv("HOME")
-- if vim.fn.has("mac") == 1 then
--     WORKSPACE_PATH = home .. "/workspace/"
--     CONFIG = "mac"
-- elseif vim.fn.has("unix") == 1 then
--     WORKSPACE_PATH = home .. "/workspace/"
--     CONFIG = "linux"
-- else
--     print("Unsupported system")
-- end

-- -- Find root of project
-- local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
-- local root_dir = require("jdtls.setup").find_root(root_markers)
-- if root_dir == "" then
--     return
-- end

-- local extendedClientCapabilities = jdtls.extendedClientCapabilities
-- extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- local workspace_dir = WORKSPACE_PATH .. project_name

-- local bundles = {}
-- local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
-- vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n"))
-- vim.list_extend(
--     bundles,
--     vim.split(
--         vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
--         "\n"
--     )
-- )

-- -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
-- local config = {
--     -- The command that starts the language server
--     -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--     cmd = {

--         -- 💀
--         "java", -- or '/path/to/java11_or_newer/bin/java'
--         -- depends on if `java` is in your $PATH env variable and if it points to the right version.

--         "-Declipse.application=org.eclipse.jdt.ls.core.id1",
--         "-Dosgi.bundles.defaultStartLevel=4",
--         "-Declipse.product=org.eclipse.jdt.ls.core.product",
--         "-Dlog.protocol=true",
--         "-Dlog.level=ALL",
--         "-javaagent: ~/.local/share/nvim/mason/packages/jdtls/lombok.jar",
--         "-Xms1g",
--         "--add-modules=ALL-SYSTEM",
--         "--add-opens",
--         "java.base/java.util=ALL-UNNAMED",
--         "--add-opens",
--         "java.base/java.lang=ALL-UNNAMED",

--         -- 💀
--         "-jar",
--         vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
--         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
--         -- Must point to the                                                     Change this to
--         -- eclipse.jdt.ls installation                                           the actual version

--         -- 💀
--         "-configuration",
--         home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. CONFIG,
--         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
--         -- Must point to the                      Change to one of `linux`, `win` or `mac`
--         -- eclipse.jdt.ls installation            Depending on your system.

--         -- 💀
--         -- See `data directory configuration` section in the README
--         "-data",
--         workspace_dir,
--     },

--     -- on_attach = require("lvim.lsp").on_attach,
--     capabilities = capabilities,

--     -- 💀
--     -- This is the default if not provided, you can remove it. Or adjust as needed.
--     -- One dedicated LSP server & client will be started per unique root_dir
--     root_dir = root_dir,

--     -- Here you can configure eclipse.jdt.ls specific settings
--     -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--     -- or https://github.com/redhat-developer/vscode-java#supported-vs-code-settings
--     -- for a list of options
--     settings = {
--         java = {
--             -- jdt = {
--             --   ls = {
--             --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
--             --   }
--             -- },
--             eclipse = {
--                 downloadSources = true,
--             },
--             configuration = {
--                 updateBuildConfiguration = "interactive",
--                 runtimes = {
--                     {
--                         name = "JavaSE-11",
--                         path = "~/.sdkman/candidates/java/11.0.2-open",
--                     },
--                     {
--                         name = "JavaSE-18",
--                         path = "~/.sdkman/candidates/java/18.0.1.1-open",
--                     },
--                     {
--                         name = "JavaSE-17",
--                         path = "~/.sdkman/candidates/java/17.0.4-oracle",
--                     },
--                 },
--             },
--             maven = {
--                 downloadSources = true,
--             },
--             implementationsCodeLens = {
--                 enabled = true,
--             },
--             referencesCodeLens = {
--                 enabled = true,
--             },
--             references = {
--                 includeDecompiledSources = true,
--             },
--             inlayHints = {
--                 parameterNames = {
--                     enabled = "all", -- literals, all, none
--                 },
--             },
--             format = {
--                 enabled = false,
--                 -- settings = {
--                 --   profile = "asdf"
--                 -- }
--             },
--         },
--         signatureHelp = { enabled = true },
--         completion = {
--             favoriteStaticMembers = {
--                 "org.hamcrest.MatcherAssert.assertThat",
--                 "org.hamcrest.Matchers.*",
--                 "org.hamcrest.CoreMatchers.*",
--                 "org.junit.jupiter.api.Assertions.*",
--                 "java.util.Objects.requireNonNull",
--                 "java.util.Objects.requireNonNullElse",
--                 "org.mockito.Mockito.*",
--             },
--         },
--         contentProvider = { preferred = "fernflower" },
--         extendedClientCapabilities = extendedClientCapabilities,
--         sources = {
--             organizeImports = {
--                 starThreshold = 9999,
--                 staticStarThreshold = 9999,
--             },
--         },
--         codeGeneration = {
--             toString = {
--                 template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
--             },
--             useBlocks = true,
--         },
--     },

--     flags = {
--         allow_incremental_sync = true,
--     },

--     -- Language server `initializationOptions`
--     -- You need to extend the `bundles` with paths to jar files
--     -- if you want to use additional eclipse.jdt.ls plugins.
--     --
--     -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
--     --
--     -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
--     init_options = {
--         -- bundles = {},
--         bundles = bundles,
--     },
-- }

-- config["on_attach"] = function(client, bufnr)
--     local _, _ = pcall(vim.lsp.codelens.refresh)
--     require("jdtls.dap").setup_dap_main_class_configs()
--     require("jdtls").setup_dap({ hotcodereplace = "auto" })
--     require("lvim.lsp").on_attach(client, bufnr)
-- end

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--     pattern = { "*.java" },
--     callback = function()
--         local _, _ = pcall(vim.lsp.codelens.refresh)
--     end,
-- })

-- -- This starts a new client & server,
-- -- or attaches to an existing client & server depending on the `root_dir`.
-- jdtls.start_or_attach(config)

-- vim.cmd(
--     [[command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)]]
-- )
-- vim.cmd([[command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()]])
-- -- vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
-- -- -- vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
-- -- vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
-- -- -- vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"

-- local status_ok, which_key = pcall(require, "which-key")
-- if not status_ok then
--     return
-- end

-- local opts = {
--     mode = "n", -- NORMAL mode
--     prefix = "<leader>",
--     buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--     silent = true, -- use `silent` when creating keymaps
--     noremap = true, -- use `noremap` when creating keymaps
--     nowait = true, -- use `nowait` when creating keymaps
-- }

-- local vopts = {
--     mode = "v", -- VISUAL mode
--     prefix = "<leader>",
--     buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--     silent = true, -- use `silent` when creating keymaps
--     noremap = true, -- use `noremap` when creating keymaps
--     nowait = true, -- use `nowait` when creating keymaps
-- }

-- local mappings = {
--     C = {
--         name = "Java",
--         o = { "<Cmd>lua require'jdtls'.organize_imports()<CR>", "Organize Imports" },
--         v = { "<Cmd>lua require('jdtls').extract_variable()<CR>", "Extract Variable" },
--         c = { "<Cmd>lua require('jdtls').extract_constant()<CR>", "Extract Constant" },
--         t = { "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", "Test Method" },
--         T = { "<Cmd>lua require'jdtls'.test_class()<CR>", "Test Class" },
--         u = { "<Cmd>JdtUpdateConfig<CR>", "Update Config" },
--     },
-- }

-- local vmappings = {
--     C = {
--         name = "Java",
--         v = { "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", "Extract Variable" },
--         c = { "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", "Extract Constant" },
--         m = { "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "Extract Method" },
--     },
-- }

-- which_key.register(mappings, opts)
-- which_key.register(vmappings, vopts)
-- which_key.register(vmappings, vopts)
