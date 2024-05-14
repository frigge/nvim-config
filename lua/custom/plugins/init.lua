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
vim.keymap.set('n', '<leader>tu', '<cmd>s/\t/    /<cr>')
vim.keymap.set('v', '<leader>tu', '<cmd>\'<,\'>s/\t/    /<cr>')
vim.keymap.set('n', '<leader>tt', '<cmd>s/    /\t/<cr>')
vim.keymap.set('v', '<leader>tt', '<cmd>\'<,\'>s/    /\t/<cr>')

vim.keymap.set('n', '<C-J>', '<cmd>cnext<cr>zz')
vim.keymap.set('n', '<C-K>', '<cmd>cprev<cr>zz')
vim.keymap.set('n', '<C-U>', '<C-U>zz')
vim.keymap.set('n', '<C-D>', '<C-D>zz')
vim.keymap.set('n', '<C-F>', '<C-F>zz')
vim.keymap.set('n', '<C-B>', '<C-B>zz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

local grep_file_under_cursor = function ()
    local folder = vim.fn.getcwd()
    vim.cmd('grep -r <cword> ' .. folder)
    vim.cmd('copen')
end
vim.keymap.set('n', '<leader>vv', grep_file_under_cursor)

vim.keymap.set('n', '<f2>', '<cmd>Git<cr>')
-- vim.g.AirLatexCookieDB = "~/.mozilla/firefox/vs4jaabt.default-release-1685526525795/cookies.sqlite";
vim.g.AirLatexCookie = "cookies:overleaf_session2=s%3ABWdAGDm0ED_zujiI5irIvO3cM8n_q9Vt.I5MCdT1MLIWQ0VphgCrFErF1MKDGTR846FWIhX71y1k;maybe_morecookies=1";
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_view_general_viewer = "termpdf"
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
        { '<leader>f', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>" },
        { '<leader>j', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>"},
        { '<leader>u', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>"},
        { '<leader>l', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>"},
        { '<leader>hh', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Toggle Harpoon Menu"},
        { '<leader>ha', "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add File to Harpoon"},
    }
    },
    {
        'nvim-orgmode/orgmode',
        config = function()
            -- Setup orgmode
            require('orgmode').setup({
                org_agenda_files = { "~/syncthing-documents/org/journals/*", "~/syncthing-documents/org/pages/*" },
                org_default_notes_file = '~/syncthing-documents/org/journals/%<%Y-%m-%d>.org',
            })
        end,
    },
    {
        "nomnivore/ollama.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        -- All the user commands added by the plugin
        cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

        keys = {
            -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
            {
                "<leader>oo",
                ":<c-u>lua require('ollama').prompt()<cr>",
                desc = "ollama prompt",
                mode = { "n", "v" },
            },

            -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
            {
                "<leader>oG",
                ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
                desc = "ollama Generate Code",
                mode = { "n", "v" },
            },
        },

        ---@type Ollama.Config
        opts = {
            -- your configuration overrides
        }
    },
    {
        "chipsenkbeil/org-roam.nvim",
        dependencies = {
            {
                "nvim-orgmode/orgmode",
                tag = "0.3.4",
            },
        },
        config = function()
            require("org-roam").setup({
                directory = "/home/frigge/syncthing-documents/org/pages",
                extensions = {
                    dailies = {
                        directory = "/home/frigge/syncthing-documents/org/journals",
                        templates = {
                            d = {
                                description = "default",
                                template = "%?",
                                target = "%<%Y_%m_%d>.org",
                            },
                        },
                    },
                },
            })
        end
    }
}
