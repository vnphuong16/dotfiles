local wezterm = require('wezterm')
local config = wezterm.config_builder()
local act = wezterm.action

-- Font, color scheme, and basic behavior
config.color_scheme = "Tokyo Night"
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium", stretch = "Expanded" })
config.font_size = 14

config.window_decorations = "RESIZE"
config.enable_tab_bar = false

config.default_cursor_style = "BlinkingUnderline"
config.cursor_thickness = 2

config.window_frame = {
    -- border_left_width = "0.18cell",
    -- border_right_width = "0.18cell",
    -- border_bottom_height = "0.08cell",
    -- border_top_height = "0.08cell",
    -- border_left_color = "pink",
    -- border_right_color = "pink",
    -- border_bottom_color = "pink",
    -- border_top_color = "pink",
}

config.window_background_opacity = 0.90
config.macos_window_background_blur = 85
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

-- Default terminal size (in character columns/rows)
config.initial_cols = 120
config.initial_rows = 30

-- Enable Ctrl+C / Ctrl+V for copy and paste
config.keys = {
  { key = "c", mods = "CTRL", action = act.CopyTo("ClipboardAndPrimarySelection") },
  { key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
}

-- Center the window on screen at startup
wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  local gui = window:gui_window()

  -- Get current screen and window dimensions
  local screen = wezterm.gui.screens().active
  local dims = gui:get_dimensions()

  -- Calculate center position
  local x = math.floor(screen.x + (screen.width  - dims.pixel_width)  / 2)
  local y = math.floor(screen.y + (screen.height - dims.pixel_height) / 2)

  -- Move window to the center
  gui:set_position(x, y)
end)

return config
