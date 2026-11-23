local vars = require("variables")

hl.bind(vars.mainMod .. " + SPACE", hl.dsp.exec_cmd(vars.launcher))
hl.bind(vars.mainMod .. " + RETURN", hl.dsp.exec_cmd(vars.terminal))
hl.bind(vars.mainMod .. " + B", hl.dsp.exec_cmd(vars.browser))
hl.bind(vars.mainMod .. " + E", hl.dsp.exec_cmd(vars.fileManager))

hl.bind(vars.mainMod .. " + M",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(vars.mainMod .. " + Q", hl.dsp.window.close())
hl.bind(vars.mainMod .. " + D", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(vars.mainMod .. " + F", hl.dsp.window.fullscreen())

local function focusAndRaise(direction)
    hl.dispatch(hl.dsp.focus({ direction = direction }))
    hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end

hl.bind(vars.mainMod .. " + H", function() focusAndRaise("left") end)
hl.bind(vars.mainMod .. " + J", function() focusAndRaise("down") end)
hl.bind(vars.mainMod .. " + K", function() focusAndRaise("up") end)
hl.bind(vars.mainMod .. " + L", function() focusAndRaise("right") end)

local function moveWindow(direction, x, y)
    local window = hl.get_active_window()
    if not window then
        return
    end

    if window.floating then
        hl.dispatch(hl.dsp.window.move({
            window = window,
            x = x,
            y = y,
            relative = true,
        }))
    else
        hl.dispatch(hl.dsp.window.move({
            window = window,
            direction = direction,
        }))
    end
end

hl.bind(vars.mainMod .. " + SHIFT + H", function() moveWindow("left", -20, 0) end, { repeating = true })
hl.bind(vars.mainMod .. " + SHIFT + J", function() moveWindow("down", 0, 20) end, { repeating = true })
hl.bind(vars.mainMod .. " + SHIFT + K", function() moveWindow("up", 0, -20) end, { repeating = true })
hl.bind(vars.mainMod .. " + SHIFT + L", function() moveWindow("right", 20, 0) end, { repeating = true })

hl.bind(vars.mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(vars.mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind(vars.mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
hl.bind(vars.mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })

for i = 1, 10 do
    local key = i % 10
    hl.bind(vars.mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(vars.mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(vars.mainMod .. " + ALT + H", hl.dsp.workspace.move({ monitor = vars.monitors.external }))
hl.bind(vars.mainMod .. " + ALT + L", hl.dsp.workspace.move({ monitor = vars.monitors.laptop }))

hl.bind(vars.mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(vars.mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
