
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

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

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
--#region STEAM

-- hl.window_rule({
    -- match = {
        -- class = "steam",
        -- title = "Steam",
    -- }
-- })

--#endregion STEAM


--#region GODOT

-- Main editor window is tiled
hl.window_rule({
    match = {
        class = "^(Godot)$",
        title = "^(Godot)(.*)$",
    },
    tile = true,
})

-- Everything else from Godot floats
hl.window_rule({
    match = {
        class = "^(Godot)$",
        title = "negative:^(Godot)(.*)$",
    },
    float = true,
})
--#endregion GODOT


--#region ANKI

hl.window_rule({
    name = "Anki Edit Current Float",
    match = {
        class = "anki",
        title = "Edit Current",
    },
    float = true,
})

-- hl.window_rule({
    -- name = "Anki Browse Float",
    -- match = {
        -- class = "anki",
        -- title = "^Browse",
    -- },
    -- float = true,
-- })

hl.on("window.title", function(w)
    if w == nil then
        return
    end

    if w.class == "anki" and w.title:match("^Browse") then
        hl.dispatch(hl.dsp.window.float({ action = "set" }))
    end
end)
--#endregion

--#region Obsidian

hl.window_rule({
    match = {
        class = "^md\\.obsidian\\.Obsidian$",
        title = "^Settings.*",
    },
    float = true,
})
--#endregion
