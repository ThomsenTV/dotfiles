-- Basic Syntax:
-- hl.bind(*keys, *dispatcher, {flag1 =  true, flag2 = true})

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "rofi -show"
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + U", hl.dsp.layout("togglesplit"))    -- dwindle only
-- Toggle fullscreen
hl.bind(mainMod .. " + D", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })) --maximize
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" })) --fullscreen 

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Minimize windoes with Super + X
hl.bind(mainMod .. " + X", function ()
    if hl.get_workspace("special:minimized") then
        hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace(), window = "tag:minimized" }))
        hl.dispatch(hl.dsp.window.clear_tags({ window = "tag:minimized" }))
    else
        hl.dispatch(hl.dsp.window.tag({ tag = "minimized", window = hl.get_active_window() }))
        hl.dispatch(hl.dsp.window.move({ workspace = "special:minimized", follow = false }))
    end
end)

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

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

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -')) -- Open in Swappy
hl.bind("SUPER + Print", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy')) -- copy to clipboard

-- Suspend to both on lid closed or power button pressed
hl.bind(
    "switch:on:Lid Switch",
    hl.dsp.exec_cmd("systemctl sleep"),
    { locked = true }
)
hl.bind(
    "XF86PowerOff",
    hl.dsp.exec_cmd("systemctl sleep"),
    { locked = true }
)

---------------------
---- Temperature ----
---------------------

-- Enter temperature mode
hl.bind("SUPER + T", hl.dsp.submap("temperature"))

hl.define_submap("temperature", function()

    hl.bind("SUPER + 0",
        hl.dsp.exec_cmd(
            "busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 6500"
        )
    )

    hl.bind("SUPER + 1",
        hl.dsp.exec_cmd(
            "busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 4500"
        )
    )

    hl.bind("SUPER + 2",
        hl.dsp.exec_cmd(
            "busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 2500"
        )
    )

    hl.bind("SUPER + 3",
        hl.dsp.exec_cmd(
            "busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 8000"
        )
    )


    hl.bind("catchall", hl.dsp.submap("reset"))
end)

