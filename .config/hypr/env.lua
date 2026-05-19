-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

local home = os.getenv("HOME")
local path = os.getenv("PATH")

hl.env("PATH", path .. ":" .. home .. "/.local/bin:" .. home .. "/Android/Sdk/platform-tools")

hl.env("GDK_BACKEND", "wayland,x11,*")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- XDG
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
-- Ensure the XDG Menu system points to the menu structure provided by archlinux-xdg-menu package
hl.env("XDG_MENU_PREFIX", "arch-")

-- Qt
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- Default screenshots location
hl.env("HYPRSHOT_DIR", home .. "/pix/screenshots")
