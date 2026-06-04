-- ///////////// PROGRAMS /////////////

local terminal          = "kitty"
local fileManager       = "dolphin"
local statusBar         = "pkill waybar && waybar &"

local menu              = "pkill rofi || rofi -show drun"
local powerMenu         = "pkill rofi || powermenu.sh"
local webSearch         = "pkill rofi || rofi-web-search.sh"
local clipboard         = "pkill rofi || rofi-cliphist-img.sh"

local screenshot        = "pkill hyprshot || pkill slurp || hyprshot"
local screenshotEditor  = "satty"

local colorPicker       = "pkill hyprpicker || hyprpicker -a"
local colorPickerMenu   = "pkill hyprpicker || pkill rofi || rofi-color-picker.sh"

-- ///////////// BINDS /////////////

-- https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod = "SUPER"

hl.bind(mainMod .. " + Q",         hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C",         hl.dsp.window.close())
hl.bind(mainMod .. " + D",         hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd(webSearch))
hl.bind(mainMod .. " + L",         hl.dsp.exec_cmd(powerMenu))
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(statusBar))

-- Color picker
hl.bind(mainMod .. " + I",         hl.dsp.exec_cmd(colorPicker))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd(colorPickerMenu))

-- OpenRGB
hl.bind(mainMod .. " + O",         hl.dsp.exec_cmd("openrgb-control.sh --toggle"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("openrgb-control.sh --cycle"))

-- Clipboard
hl.bind(mainMod .. " + V",         hl.dsp.exec_cmd(clipboard))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("pkill rofi & clip-clear.sh")) -- clear

-- Screen capture
hl.bind(mainMod .. " + S",         hl.dsp.exec_cmd(screenshot .. " -m region --clipboard-only")) -- capture a region to clipboard
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(screenshot .. " -m region --raw | " .. screenshotEditor .. " --filename -")) -- capture a region and edit
hl.bind(mainMod .. " + PRINT",     hl.dsp.exec_cmd(screenshot .. " -m window")) -- capture a window
hl.bind("PRINT",                   hl.dsp.exec_cmd(screenshot .. " -m output")) -- capture a monitor

-- WINDOW

hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + P",         hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",         hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + H",         hl.dsp.window.float({ action = "toggle" }))

-- Focus window
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Swap window
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.swap({ direction = "down" }))

-- Move/resize window
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- WORKSPACE

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + K",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- MEDIA

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
