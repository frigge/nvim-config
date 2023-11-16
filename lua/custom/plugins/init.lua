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
        { '<c-1>', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>" },
        { '<c-2>', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>"},
        { '<c-3>', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>"},
        { '<c-4>', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>"},
        { '<leader>hh', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Toggle Harpoon Menu"},
        { '<leader>ha', "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add File to Harpoon"},
    }
    }
}
