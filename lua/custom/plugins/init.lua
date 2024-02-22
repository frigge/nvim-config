-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.keymap.set('n', '<f5>', '<cmd>make|copen<cr>')
vim.keymap.set('n', '<leader>tu', '<cmd>retab<cr>')
vim.keymap.set('v', '<leader>tu', '<cmd>\'<,\'>retab<cr>')
vim.keymap.set('n', '<leader>tt', '<cmd>s/    /\t<cr>')
vim.keymap.set('v', '<leader>tt', '<cmd>\'<,\'>s/    /\t<cr>')
vim.keymap.set('n', '<f2>', '<cmd>Git<cr>')

return {
    'tikhomirov/vim-glsl',
    'sbdchd/neoformat',
    'tpope/vim-surround',

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

    {
        'mfussenegger/nvim-dap', config = function ()
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
    {
        'ThePrimeagen/harpoon', opts = {} ,keys = {
            { '<c-1>', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>" },
            { '<c-2>', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>"},
            { '<c-3>', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>"},
            { '<c-4>', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>"},
            { '<leader>hh', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Toggle Harpoon Menu"},
            { '<leader>ha', "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add File to Harpoon"},
        },
    },

    {
        'nvim-orgmode/orgmode',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter', lazy = true },
        },
        config = function()
            -- Load treesitter grammar for org
            require('orgmode').setup_ts_grammar()

            -- Setup treesitter
            require('nvim-treesitter.configs').setup({
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { 'org' },
                },
                ensure_installed = { 'org' },
            })

            -- Setup orgmode
            require('orgmode').setup({
                org_agenda_files = '~/syncthing/documents/org/journal',
                org_default_notes_file = '~/syncthing/documents/org/inbox.org',
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
    }
}
