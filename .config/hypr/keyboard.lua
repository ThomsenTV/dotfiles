hl.config({
    input = {
        kb_layout = "de",
        kb_variant = "",
        kb_model = "latitude",
        kb_options = "caps:escape_shifted_capslock",
        kb_rules = "",


        numlock_by_default = true,
        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            disable_while_typing = true,
            middle_button_emulation = true,
            tap_to_click = true,
            natural_scroll = false,
        },
    },
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "razer-razer-deathadder-v2-x-hyperspeed",
    sensitivity = 0.0,
    accel_profile = "flat",
})
