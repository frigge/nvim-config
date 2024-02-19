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
    'sbdchd/neoformat',
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
        { '<leader>1', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>" },
        { '<leader>2', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>"},
        { '<leader>3', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>"},
        { '<leader>4', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>"},
        { '<leader>hh', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Toggle Harpoon Menu"},
        { '<leader>ha', "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add File to Harpoon"},
    }
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
                org_agenda_files = '~/orgfiles/**/*',
                org_default_notes_file = '~/orgfiles/refile.org',
            })
        end,
    }
}
