return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    local dashboard = require 'alpha.themes.dashboard'
    local logo = [[
   __   _ ______  _____  _    _ _____ _______
   | \  | |_____ |     |  \  /    |   |  |  |
   |  \_| |_____ |_____|   \/   __|__ |  |  |
 ]]

    dashboard.section.header.val = vim.split(logo, '\n')
    return dashboard
  end,
  config = function(_, dashboard)
    require('alpha').setup(dashboard.opts)
  end,
}
