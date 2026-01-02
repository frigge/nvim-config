-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.keymap.set('n', '<f5>', '<cmd>make|copen<cr>')

local compile_current_shader_in_other_tmux_pane = function ()
    local filename = vim.fn.expand("%:t")
    vim.cmd('!tmux send-keys -t 1 "make ' .. filename .. '.spv.spv" Enter')
end

vim.keymap.set('n', '<f4>', compile_current_shader_in_other_tmux_pane)

-- juggle with mixed tabs and spaces
vim.keymap.set('n', '<leader>tu', '<cmd>s/\t/    /<cr>', { desc = 'replace tabs by four spaces' })
vim.keymap.set('v', '<leader>tu', '<cmd>\'<,\'>s/\t/    /<cr>', { desc = 'replace tabs in range by four spaces' })
vim.keymap.set('n', '<leader>tt', '<cmd>s/    /\t/<cr>', { desc = 'replace four spaces by tab' })
vim.keymap.set('v', '<leader>tt', '<cmd>\'<,\'>s/    /\t/<cr>', { desc = 'replace four space in range by tab' })

vim.keymap.set('n', '<C-J>', '<cmd>cnext<cr>zz')
vim.keymap.set('n', '<C-K>', '<cmd>cprev<cr>zz')
vim.keymap.set('n', '<C-H>', '<cmd>col<cr>zz')
vim.keymap.set('n', '<C-L>', '<cmd>cnewer<cr>zz')
vim.keymap.set('n', '<C-U>', '<C-U>zz')
vim.keymap.set('n', '<C-D>', '<C-D>zz')
vim.keymap.set('n', '<C-F>', '<C-F>zz')
vim.keymap.set('n', '<C-B>', '<C-B>zz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

local grep_word_under_cursor = function ()
    local folder = vim.fn.getcwd()
    vim.cmd('grep -r <cword> ' .. folder)
    vim.cmd('copen')
end
vim.keymap.set('n', '<leader>vv', grep_word_under_cursor, { desc = 'grep word under cursor' })

vim.keymap.set('n', '<f2>', '<cmd>Git<cr>')
-- vim.g.AirLatexCookieDB = "~/.mozilla/firefox/vs4jaabt.default-release-1685526525795/cookies.sqlite";
vim.g.AirLatexCookie = "cookies:overleaf_session2=s%3ABWdAGDm0ED_zujiI5irIvO3cM8n_q9Vt.I5MCdT1MLIWQ0VphgCrFErF1MKDGTR846FWIhX71y1k;maybe_morecookies=1";
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_view_general_viewer = "zathura"

vim.opt.conceallevel = 2
vim.opt.concealcursor = 'nc'
vim.opt.scrolloff = 5

-- vim.g.AirLatexUsername = "cookies:overleaf_session2=s%3ABWdAGDm0ED_zujiI5irIvO3cM8n_q9Vt.I5MCdT1MLIWQ0VphgCrFErF1MKDGTR846FWIhX71y1k";
-- vim.g.AirLatexUseHTTPS = 1;
-- vim.g.AirLatexAllowInsecure = 0;

return {
    'tikhomirov/vim-glsl',
    -- 'sbdchd/neoformat',
    'tpope/vim-surround',
    'lervag/vimtex',
    -- 'da-h/AirLatex.vim',
    'dmadisetti/AirLatex.vim',
    {
      "HakonHarnes/img-clip.nvim",
      event = "BufEnter",
      opts = {
        -- add options here
        -- or leave it empty to use the default settings
      },
      keys = {
        -- suggested keymap
        { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
      },
    },
    { 'mfussenegger/nvim-dap', config = function ()
            local dap = require('dap')
            dap.configurations.python = {
                {
                    type = 'python';
                    request = 'launch';
                    name = "Launch file";
                    program = "${file}";
                    pythonPath = function()
                        return '/usr/bin/python'
                    end;
                },
            }
            dap.configurations.cpp = {
                {
                    type = 'cpp';
                    request = 'launch';
                    name = "Launch file";
                    program = "${file}";
                    pythonPath = function()
                        return '/usr/sbin/gdb'
                    end;
                },
            }

            dap.adapters.python = {
                type = 'executable';
                command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python';
                args = { '-m', 'debugpy.adapter' };
            }

            dap.adapters.cpp = {
                type = 'executable';
                command = 'gdb';
                args = {  };
            }

        end
    },
    -- { 'uZer/pywal16.nvim', opts = {} },
    { 'ThePrimeagen/harpoon', opts = {} ,keys = {
        { '<leader>f', "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Prev Harpooned File" },
        { '<leader>j', "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Next Harpooned File" },
        { '<leader>hh', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Toggle Harpoon Menu"},
        { '<leader>ha', "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add File to Harpoon"},
    }
    },
    -- {
    --     'nvim-orgmode/orgmode',
    --     config = function()
    --         -- Setup orgmode
    --         require('orgmode').setup({
    --             org_agenda_files = { "/mnt/piland/sascha/documents/org/files/journals/*", "/mnt/piland/sascha/documents/org/pages/*" },
    --             org_default_notes_file = '/mnt/piland/sascha/documents/org/files/journals/%<%Y-%m-%d>.org',
    --         })
    --     end,
    -- },
    -- {
    --     "chipsenkbeil/org-roam.nvim",
    --     dependencies = {
    --         {
    --             "nvim-orgmode/orgmode",
    --             tag = "0.3.4",
    --         },
    --     },
    --     config = function()
    --         require("org-roam").setup({
    --             directory = "/mnt/piland/sascha/documents/org/files",
    --             extensions = {
    --                 dailies = {
    --                     directory = "/mnt/piland/sascha/documents/org/files/journals",
    --                     templates = {
    --                         d = {
    --                             description = "default",
    --                             template = "%?",
    --                             target = "%<%Y_%m_%d>.org",
    --                         },
    --                     },
    --                 },
    --             },
    --         })
    --     end
    -- },
    {
        "David-Kunz/gen.nvim",
        opts = {
            model = "mistral:instruct", -- The default model to use.
            host = "localhost", -- The host running the Ollama service.
            port = "11434", -- The port on which the Ollama service is listening.
            display_mode = "float", -- The display mode. Can be "float" or "split".
            show_prompt = false, -- Shows the Prompt submitted to Ollama.
            show_model = false, -- Displays which model you are using at the beginning of your chat session.
            quit_map = "q", -- set keymap for quit
            retry_map = "<c-r>", -- set keymap for retry
            no_auto_close = false, -- Never closes the window automatically.
            init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
            -- Function to initialize Ollama
            command = function(options)
                return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
            end,
            -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
            -- This can also be a command string.
            -- The executed command must return a JSON object with { response, context }
            -- (context property is optional).
            -- list_models = '<omitted lua function>', -- Retrieves a list of model names
            debug = false -- Prints errors and the command which is run.
        }
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require('treesitter-context').setup({
            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
            multiwindow = false, -- Enable multiwindow support.
            max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 20, -- Maximum number of lines to show for a single context
            trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = nil,
            zindex = 20, -- The Z-index of the context window
            on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        })
        end,
    },
    {
        "gruvw/strudel.nvim",
        build = "npm install",
        config = function()
            require("strudel").setup()
        end,
    }
}
