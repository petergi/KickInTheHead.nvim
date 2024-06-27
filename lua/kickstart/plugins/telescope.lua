-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-media-files.nvim',
      'nvim-telescope/telescope-dap.nvim',
      'nvim-telescope/telescope-symbols.nvim',
      'nvim-telescope/telescope-node-modules.nvim',
      {
        'stevearc/aerial.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = {
          'nvim-treesitter/nvim-treesitter',
          'nvim-tree/nvim-web-devicons',
        },
      },

      {
        'davvid/telescope-git-selector.nvim',
        dependencies = { 'davvid/telescope-git-grep.nvim' },
      },
      'gbrlsnchs/telescope-lsp-handlers.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('aerial').setup {
        backends = {
          ['_'] = { 'treesitter', 'lsp', 'markdown', 'asciidoc', 'man' },
        },
        close_automatic_events = { 'unfocus' },
        close_on_select = true,
        autojump = true,
        --false,
        filter_kind = { 'Module', 'Method', 'Struct', 'Class', 'Constructor', 'Enum', 'Function', 'Interface' },
        highlight_on_hover = true,
        show_guides = true,
        lsp = {
          -- If true, fetch document symbols when LSP diagnostics update.
          diagnostics_trigger_update = true,

          -- Set to false to not update the symbols when there are LSP errors
          update_when_errors = true,

          -- How long to wait (in ms) after a buffer change before updating
          -- Only used when diagnostics_trigger_update = false
          update_delay = 300,

          -- Map of LSP client name to priority. Default value is 10.
          -- Clients with higher (larger) priority will be used before those with lower priority.
          -- Set to -1 to never use the client.
          priority = {
            -- pyright = -1,
          },
        },
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
          vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end,
      }
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"/command
            --
          },
          aerial = {
            -- Display symbols as <root>.<parent>.<symbol>
            show_nesting = {
              ['_'] = true, -- This key will be the default
              json = true, -- You can set the option for specific filetypes
              yaml = true,
            },
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'aerial')
      pcall(require('telescope').load_extension, 'dap')
      pcall(require('telescope').load_extension, 'noice')
      pcall(require('telescope').load_extension, 'node_modules')
      pcall(require('telescope').load_extension, 'lsp_handlers')
      pcall(require('telescope').load_extension, 'git_selector')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      vim.keymap.set('n', '<leader>Nh', function()
        require('noice').cmd 'history'
      end, { desc = 'history' })

      vim.keymap.set('c', '<S-Enter>', function()
        require('noice').redirect(vim.fn.getcmdline())
      end, { desc = 'Redirect Cmdline' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
