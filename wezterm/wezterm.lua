local wezterm = require 'wezterm'
local config = {}
local mux = wezterm.mux
local projects = require 'projects'

-- Decide whether cmd represents a default startup invocation
local function is_default_startup(cmd)
  if not cmd then
    -- we were started with `wezterm` or `wezterm start` with
    -- no other arguments
    return true
  end
  if cmd.domain == "DefaultDomain" and not cmd.args then
    -- Launched via `wezterm start --cwd something`
    return true
  end
  -- we were launched some other way
  return false
end

wezterm.on('gui-startup', function(cmd)
  if is_default_startup(cmd) then
    -- for the default startup case, we want to switch to the unix domain instead
    local unix = mux.get_domain("unix")
    mux.set_default_domain(unix)
    -- ensure that it is attached
    unix:attach()
  end
end)

local function move_pane(key, direction)
  return {
    key = key,
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection(direction)
  }
end

local function resize_pane(key, direction)
  return {
    key = key,
    mods = "NONE",
    action = wezterm.action.AdjustPaneSize({ direction, 5 }),
  }
end

-- Theme options
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font 'DroidSansM Nerd Font'

-- Configure unix session
config.unix_domains = {{ name = "unix" }}

-- Configure keybinds
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- splitting
  {
    mods   = "LEADER|SHIFT",
    key    = "\"",
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
  },
  {
    mods   = "LEADER|SHIFT",
    key    = "%",
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
  },
  -- zoom
  {
    mods   = 'LEADER',
    key    = 'z',
    action = wezterm.action.TogglePaneZoomState
  },
  -- Spawn new tab
  {
    mods   = 'LEADER',
    key    = 't',
    action = wezterm.action.SpawnTab('CurrentPaneDomain')
  },
  -- Resize windows
  {
    key = 'r',
    mods = 'LEADER',
    -- Activate the `resize_panes` keytable
    action = wezterm.action.ActivateKeyTable {
      name = 'resize_panes',
      -- Ensures the keytable stays active after it handles its
      -- first keypress.
      one_shot = false,
      -- Deactivate the keytable after a timeout.
      timeout_milliseconds = 1000,
    }
  },
  -- Kill pane
  {
    key='x',
    mods='LEADER',
    action=wezterm.action.CloseCurrentPane { confirm = true }
  },
  -- Pane navigation
  move_pane('j', 'Down'),
  move_pane('k', 'Up'),
  move_pane('h', 'Left'),
  move_pane('l', 'Right'),
  -- Workspaces
  {
    key = 'w',
    mods = 'LEADER',
    -- Present in to our project picker
    action = projects.choose_project(),
  },
  {
    key = 'f',
    mods = 'LEADER',
    -- Present a list of existing workspaces
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
  },
  -- Activate copy mode
  {
    key = "c",
    mods = "LEADER",
    action = wezterm.action.ActivateCopyMode
  },
}

-- Tab quick select
for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = wezterm.action.ActivateTab(i - 1),
    })
end

config.key_tables = {
  resize_panes = {
    resize_pane('j', 'Down'),
    resize_pane('k', 'Up'),
    resize_pane('h', 'Left'),
    resize_pane('l', 'Right'),
  },
  copy_mode = {
      {key="c", mods="CTRL", action=wezterm.action.CopyMode("Close")},
      {key="g", mods="CTRL", action=wezterm.action.CopyMode("Close")},
      {key="q", mods="NONE", action=wezterm.action.CopyMode("Close")},
      {key="Escape", mods="NONE", action=wezterm.action.CopyMode("Close")},

      {key="h", mods="NONE", action=wezterm.action.CopyMode("MoveLeft")},
      {key="j", mods="NONE", action=wezterm.action.CopyMode("MoveDown")},
      {key="k", mods="NONE", action=wezterm.action.CopyMode("MoveUp")},
      {key="l", mods="NONE", action=wezterm.action.CopyMode("MoveRight")},

      {key="LeftArrow",  mods="NONE", action=wezterm.action.CopyMode("MoveLeft")},
      {key="DownArrow",  mods="NONE", action=wezterm.action.CopyMode("MoveDown")},
      {key="UpArrow",    mods="NONE", action=wezterm.action.CopyMode("MoveUp")},
      {key="RightArrow", mods="NONE", action=wezterm.action.CopyMode("MoveRight")},

      {key="RightArrow", mods="ALT",  action=wezterm.action.CopyMode("MoveForwardWord")},
      {key="f",          mods="ALT",  action=wezterm.action.CopyMode("MoveForwardWord")},
      {key="Tab",        mods="NONE", action=wezterm.action.CopyMode("MoveForwardWord")},
      {key="w",          mods="NONE", action=wezterm.action.CopyMode("MoveForwardWord")},

      {key="LeftArrow", mods="ALT",   action=wezterm.action.CopyMode("MoveBackwardWord")},
      {key="b",         mods="ALT",   action=wezterm.action.CopyMode("MoveBackwardWord")},
      {key="Tab",       mods="SHIFT", action=wezterm.action.CopyMode("MoveBackwardWord")},
      {key="b",         mods="NONE",  action=wezterm.action.CopyMode("MoveBackwardWord")},

      {key="0",     mods="NONE",  action=wezterm.action.CopyMode("MoveToStartOfLine")},
      {key="Enter", mods="NONE",  action=wezterm.action.CopyMode("MoveToStartOfNextLine")},

      {key="$",     mods="NONE",  action=wezterm.action.CopyMode("MoveToEndOfLineContent")},
      {key="$",     mods="SHIFT", action=wezterm.action.CopyMode("MoveToEndOfLineContent")},
      {key="^",     mods="NONE",  action=wezterm.action.CopyMode("MoveToStartOfLineContent")},
      {key="^",     mods="SHIFT", action=wezterm.action.CopyMode("MoveToStartOfLineContent")},
      {key="m",     mods="ALT",   action=wezterm.action.CopyMode("MoveToStartOfLineContent")},

      {key=" ", mods="NONE",  action=wezterm.action.CopyMode{SetSelectionMode="Cell"}},
      {key="v", mods="NONE",  action=wezterm.action.CopyMode{SetSelectionMode="Cell"}},
      {key="V", mods="NONE",  action=wezterm.action.CopyMode{SetSelectionMode="Line"}},
      {key="V", mods="SHIFT", action=wezterm.action.CopyMode{SetSelectionMode="Line"}},
      {key="v", mods="CTRL",  action=wezterm.action.CopyMode{SetSelectionMode="Block"}},

      {key="G", mods="NONE",  action=wezterm.action.CopyMode("MoveToScrollbackBottom")},
      {key="G", mods="SHIFT", action=wezterm.action.CopyMode("MoveToScrollbackBottom")},
      {key="g", mods="NONE",  action=wezterm.action.CopyMode("MoveToScrollbackTop")},

      {key="H", mods="NONE",  action=wezterm.action.CopyMode("MoveToViewportTop")},
      {key="H", mods="SHIFT", action=wezterm.action.CopyMode("MoveToViewportTop")},
      {key="M", mods="NONE",  action=wezterm.action.CopyMode("MoveToViewportMiddle")},
      {key="M", mods="SHIFT", action=wezterm.action.CopyMode("MoveToViewportMiddle")},
      {key="L", mods="NONE",  action=wezterm.action.CopyMode("MoveToViewportBottom")},
      {key="L", mods="SHIFT", action=wezterm.action.CopyMode("MoveToViewportBottom")},

      {key="o", mods="NONE",  action=wezterm.action.CopyMode("MoveToSelectionOtherEnd")},
      {key="O", mods="NONE",  action=wezterm.action.CopyMode("MoveToSelectionOtherEndHoriz")},
      {key="O", mods="SHIFT", action=wezterm.action.CopyMode("MoveToSelectionOtherEndHoriz")},

      {key="PageUp",   mods="NONE", action=wezterm.action.CopyMode("PageUp")},
      {key="PageDown", mods="NONE", action=wezterm.action.CopyMode("PageDown")},

      {key="u", mods="CTRL", action=wezterm.action.CopyMode("PageUp")},
      {key="d", mods="CTRL", action=wezterm.action.CopyMode("PageDown")},

      -- Enter y to copy and quit the copy mode.
      {key="y", mods="NONE", action=wezterm.action.Multiple{
        wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
        wezterm.action.CopyMode("Close"),
      }},
      -- Enter search mode to edit the pattern.
      -- When the search pattern is an empty string the existing pattern is preserved
      {key="/", mods="NONE", action=wezterm.action{Search={CaseSensitiveString=""}}},
      {key="?", mods="NONE", action=wezterm.action{Search={CaseInSensitiveString=""}}},
      {key="n", mods="NONE", action=wezterm.action{CopyMode="NextMatch"}},
      {key="p", mods="NONE", action=wezterm.action{CopyMode="PriorMatch"}},
    },
}

return config
