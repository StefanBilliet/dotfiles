-- ~/.wezterm.lua

local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

------------------------------------------------------------
-- Appearance
------------------------------------------------------------

config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  "Symbols Nerd Font",
})

config.font_size = 13.5
config.line_height = 1.15

config.window_background_opacity = 0.92
config.macos_window_background_blur = 20

config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.audible_bell = "Disabled"

local schemes = wezterm.color.get_builtin_schemes()
local aurora = schemes["Aurora"]

-- ANSI blue (used by brew's "==>") is too dark: brighten it
aurora.ansi[5] = "#81a1c1"     -- blue
aurora.brights[5] = "#81a1c1"  -- bright blue

config.color_schemes = {
  ["Aurora (patched)"] = aurora,
}
config.color_scheme = "Aurora (patched)"

------------------------------------------------------------
-- Tab bar
------------------------------------------------------------

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false

------------------------------------------------------------
-- macOS Option / dead key behavior (iTerm2-like)
------------------------------------------------------------

-- Let macOS handle dead keys so Option+n works as expected
config.use_dead_keys = true

-- Make *both* Option keys behave like compose keys
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

------------------------------------------------------------
-- Shell / environment
------------------------------------------------------------

config.set_environment_variables = {
  TERM = "wezterm",
}

------------------------------------------------------------
-- Workspace & command palette
------------------------------------------------------------

config.keys = {
  -- Command palette
  { key = "p", mods = "CTRL|SHIFT", action = act.ActivateCommandPalette },

  -- Workspace switcher
  {
    key = "w",
    mods = "CTRL|SHIFT",
    action = act.ShowLauncherArgs({ flags = "WORKSPACES" }),
  },

------------------------------------------------------------
-- Pane management (vim-style, no mouse dependency)
------------------------------------------------------------

  { key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
  { key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
  { key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },

  -- Splits
  { key = "d", mods = "CTRL|SHIFT", action = act.SplitHorizontal },
  { key = "D", mods = "CTRL|SHIFT", action = act.SplitVertical },

------------------------------------------------------------
-- Safe fallback for typing "~" (no Raycast conflict)
------------------------------------------------------------

  -- Explicit shortcut to emit ~ without dead-key drama
  { key = "n", mods = "CMD|OPT", action = act.SendString("~") },
}

------------------------------------------------------------
-- Mouse: select = copy
------------------------------------------------------------

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelection("Clipboard"),
  },
}

------------------------------------------------------------
-- SSH awareness (visual cue)
------------------------------------------------------------

wezterm.on("update-right-status", function(window, pane)
  local cwd = pane:get_current_working_dir()
  if cwd and cwd:find("ssh") then
    window:set_right_status(" 🌐 SSH ")
  else
    window:set_right_status("")
  end
end)

------------------------------------------------------------
-- Misc sanity
------------------------------------------------------------

config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = "NeverPrompt"

return config