-- To update all plugins press 'CTRL+SHIFT+L' to open the debug console then run:
-- - wezterm.plugin.update_all()
-- The keyboard shortcut should run the command `wezterm connect unix` to correctly
-- run with the muxed domain

local wezterm = require 'wezterm'
local config = {}
local keymap = require 'keymap'

-- Add plugins
local sessionizer = wezterm.plugin.require "https://github.com/mikkasendke/sessionizer.wezterm"
local history = wezterm.plugin.require "https://github.com/mikkasendke/sessionizer-history"
local zoxide = wezterm.plugin.require "https://github.com/mikkasendke/sessionizer-zoxide.git"
local domains = wezterm.plugin.require "https://github.com/DavidRR-F/quick_domains.wezterm"

-- Theme options
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font 'DroidSansM Nerd Font'

-- Configure keybinds
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = keymap.get_keymap()

-- Tab quick select
for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = wezterm.action.ActivateTab(i - 1),
    })
end

config.key_tables = keymap.get_key_tables()

-- Mux server setup (for persistent sessions)
config.unix_domains = {
  {
    name = 'unix',
  },
}

-- Apply plugin configs

-- Disable the default binds for sessionizer to customize them
sessionizer.apply_to_config(config, true)
-- Paths for sessionizer
local sessionizer_schema = {
  options = { callback = history.Wrapper(sessionizer.DefaultCallback) },
  history.MostRecentWorkspace {},
  sessionizer.DefaultWorkspace {},
  sessionizer.AllActiveWorkspaces {},
  sessionizer.FdSearch "~/projects", -- Searches for git repos in ~/projects
  zoxide.Zoxide {}
}
-- Add sessionoizer shortcuts to keymap
table.insert(config.keys,
  {
    -- List current sessions in sessionizer
    key = 's',
    mods = 'LEADER',
    action = sessionizer.show(sessionizer_schema),
  }
)

return config
