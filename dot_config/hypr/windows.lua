local gamingApps = "^(steam_app.*|gamescope)$"

hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
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

hl.window_rule({
    name  = "gaming-apps",
    match = {
        class         = gamingApps,
        title         = "^(.+)$",
        initial_title = "negative:^(.*\\\\home\\\\.*|Battle\\.net)$",
    },
    content          = "game",
    opacity          = "1.0 override",
    decorate         = false,
    fullscreen_state = 2,
    size             = { "monitor_w", "monitor_h" },
    sync_fullscreen  = true,
})

hl.window_rule({
    name  = "steam-helper-windows",
    match = {
        class         = "^(steam_app.*)$",
        initial_title = "^$",
    },
    center           = true,
    float            = true,
    fullscreen       = false,
    fullscreen_state = 0,
})

for _, contentType in ipairs({ "none", "photo", "video" }) do
    hl.window_rule({
        name  = "floating-default-" .. contentType,
        match = {
            class   = "negative:" .. gamingApps,
            content = contentType,
        },
        float           = true,
        size            = { 1600, 900 },
        persistent_size = false,
    })
end

hl.window_rule({
    name  = "battle-net",
    match = {
        class         = "^(steam_app.*)$",
        initial_title = "^Battle\\.net$",
    },
    float            = true,
    size             = { 1600, 900 },
    persistent_size  = false,
    fullscreen_state = 0,
})

hl.window_rule({
    name  = "game-tagged-windows",
    match = {
        xdg_tag = "^(.*game.*)$",
    },
    float            = false,
    fullscreen_state = 2,
    content          = "game",
    sync_fullscreen  = true,
})

local modalMatches = {
    { modal         = true },
    { title         = "^(Open|Authentication Required|Add Folder to Workspace|Choose Files|Save As|Confirm to replace files|File Operation Progress)$" },
    { initial_title = "^(Open File)$" },
    { class         = "^([Xx]dg-desktop-portal-gtk)$" },
    { title         = "^(File Upload|Choose wallpaper|Library)(.*)$" },
    { class         = "^(.*dialog.*)$" },
    { title         = "^(.*dialog.*)$" },
    { class         = "^(hyprland-share-picker)$" },
}

for _, match in ipairs(modalMatches) do
    hl.window_rule({
        match           = match,
        float           = true,
        size            = "",
        persistent_size = false,
    })
end
