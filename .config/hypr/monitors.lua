
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({ -- builtin
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto",
    scale    = "1.5",
    disabled = false,
})
hl.monitor({ -- over HDMI
    output   = "HDMI-A-1",
    --mode     = "preferred",
	mode	 = "1920x1080@60",
    position = "auto-left",
    scale    = "1.5",
    disabled = false,
})
hl.monitor({ -- over DP
    output   = "DP-1",
    mode     = "preferred",
    position = "auto-left",
    scale    = "1.5",
    disabled = false,
})
