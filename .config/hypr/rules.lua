-- ///////////// WORKSPACE /////////////

-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })

hl.window_rule({
    name        = "no-gaps-wtv1",
    match       = { float = false, workspace = "w[tv1]" },
    border_size = 0,
    rounding    = 0,
})
hl.window_rule({
    name        = "no-gaps-f1",
    match       = { float = false, workspace = "f[1]" },
    border_size = 0,
    rounding    = 0,
})

 -- ///////////// WINDOW /////////////

 -- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

hl.window_rule({
    -- Ignore maximize requests from all apps.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- System

hl.window_rule({
    name  = "system-popup",
    match = { class= "^(system-popup)" },
    size  = { 1300, 800 },
    float = true,
})

hl.window_rule({
    name        = "fullscreen-indicator",
    match       = { fullscreen = true },
    border_size = 2,
})

-- Thunar

hl.window_rule({
    name  = "thunar",
    match = { class = "thunar" },
    size  = { 1300, 750 },
    float = true,
})

hl.window_rule({
    name  = "thunar-file-op",
    match = { class = "thunar", title = "File Operation Progress" },
    size  = { 600, 150 },
})

hl.window_rule({
    name  = "thunar-replace",
    match = { class = "thunar", title = "Confirm to replace files" },
    size  = { 534, 324 },
})

hl.window_rule({
    name   = "thunar-attention",
    match  = { class = "thunar", title = "Attention" },
    size   = { 430, 183 },
    center = true,
})

hl.window_rule({
    name  = "thunar-preferences",
    match = { class = "thunar", title = "Thunar Preferences" },
    size  = { 596, 703 },
})

hl.window_rule({
    name  = "thunar-rename",
    match = { class = "thunar", title = "^Rename.*" },
    size  = { 462, 186 },
})

hl.window_rule({
    name  = "thunar-dir",
    match = { class = "thunar", title = "^Create New Folder" },
    size  = { 462, 186 },
})

-- IMV

hl.window_rule({
    name  = "float-imv",
    match = { class = "imv" },
    float = true,
})

-- MPV

hl.window_rule({
    name  = "float-mpv",
    match = { class = "mpv" },
    float = true,
})

-- Satty

hl.window_rule({
    name  = "float-satty",
    match = { class = "com.gabm.satty" },
    float = true,
})

-- LACT

hl.window_rule({
    name  = "lact",
    match = { class = "io.github.ilya_zlobintsev.LACT" },
    size  = { 1333, 774 },
    float = true,
})

-- GTK

hl.window_rule({
    name   = "gtk-portal",
    match  = { class = "xdg-desktop-portal-gtk" },
    center = true,
    size   = { 1102, 613 },
})

-- ///////////// LAYER /////////////

hl.layer_rule({
    match = { namespace = "notifications" },
    blur  = true,
})
