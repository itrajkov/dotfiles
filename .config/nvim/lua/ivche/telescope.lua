local actions = require('telescope.actions')
require('telescope').setup({
  defaults = {
    mappings = {
      n = {
        ['<c-x>'] = false,
        ['<c-s>'] = actions.select_horizontal,
        ['<c-q>'] = actions.send_to_qflist + actions.open_qflist,
        ['<c-c>'] = actions.close,
      },
      i = {
        ['<c-x>'] = false,
        ['<c-s>'] = actions.select_horizontal,
        ['<c-q>'] = actions.send_to_qflist + actions.open_qflist,
        ['<c-c>'] = actions.close,
      },
    },
    color_devicons = true,
    prompt_prefix = '🔍 ',
    sorting_strategy = 'ascending',
    layout_strategy = 'bottom_pane',
    file_ignore_patterns = { 'node_modules/.*', '.git/.*', '.neuron/*', },
    layout_config = {
      prompt_position = 'bottom',
      horizontal = {
        mirror = true,
      },
      vertical = {
        mirror = true,
      },
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
})
require('telescope').load_extension('fzy_native')

local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< VimRC >",
        cwd = vim.env.DOTFILES,
        hidden = true,
    })
end
