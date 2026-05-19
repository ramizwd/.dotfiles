-- https://wiki.hypr.land/Configuring/Basics/Variables/#input

hl.config({
    input = {
        -- KB
        kb_layout  = "us,fi",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:win_space_toggle",
        kb_rules   = "",

        -- Mouse
        follow_mouse  = 1,
        scroll_factor = 1.6,
        accel_profile = "flat",
        sensitivity   = 0.7, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})
