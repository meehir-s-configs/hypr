hl.monitor({
    output      = "eDP-1",
    mode        = "preferred",
    position    = "auto",
    scale       = "auto",
})

hl.monitor({
    output      = "HDMI-A-1",
    mode        = "preferred",
    position    = "auto",
    scale       = "auto",
    mirror      = "eDP-1"
})

hl.on("hyprland.start", function ()
    hl.exec_cmd("~/.config/hypr/bin/wallpaper.sh & hypridle & fcitx5")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("hyprctl setcursor default 24")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("kwalletd6")
    hl.exec_cmd("kdeconnect & kdeconnect-indicator")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("swaync")
    hl.exec_cmd("~/.config/hypr/bin/power_notify.sh")
end)

local theme = require("~/.cache/matugen/hyprland-colors.lua")

--program vars
local terminal      = "kitty"
local terminal1     = "alacritty"
local fileManager   = "dolphin"
local menu          = "wofi -S drun -I"

hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QUICK_CONTROLS_STYLE", "org.kde.desktop")
hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("GTK_THEME", "adw-gtk3-dark")
--hl.env("GTK2_RC_FILES", "/usr/share/themes/adw-gtk3-dark/gtk-3.0/gtkrc")
hl.env("BROWSER", "brave")

hl.config({
    -- Input
    input = {
        kb_layout  = "us",
        kb_variant = "altgr-intl",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        touchpad = {
            natural_scroll = false,
        },

        sensitivity = 0.7,
    },

    -- look and feel
    
    general = {
        gaps_in = 5,
        gaps_out = 5,
        border_size = 1,

        col = {
            active_border = { colors = {theme.primary, theme.tertiary}, angle = 45},
            inactive_border = "rgba(3c3c3c5a)",
        },

        layout = "scrolling",

        allow_tearing = true,
},

    decoration = {
        rounding    = 10,
        rounding_power = 2,

        blur = {
            enabled = true,
            size = 3,
            passes = 2,
        },

        shadow = {
            enabled = true,
            range = 10,
            render_power = 6,
            color = 0xee1a1a1a,
        },
    },

    animations = {
        enabled = true,
    },
})

-- animations
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

-- scrolling layout config

hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.667,
        -- focus_fit_method = 1,
        -- follow_focus = true,
        -- follow_min_visible = 0.4,
        explicit_column_widths = "0.333, 0.5, 0.667, 0.8, 1.0",
        -- direction = "right",
    }
})

hl.gesture({
    fingers     = 4,
    direction   = "horizontal",
    action      = "workspace"
})

hl.gesture({
    fingers     = 3,
    direction   = "pinch",
    action      = "cursorZoom",
    zoom_level  = 1,
    mode        = "live"
})

-- MISC
hl.config({
    misc = {
        force_default_wallpaper = 0
    },
})

hl.device({
    name = "usb-optical-mouse-",
    sensitivity = 1.0,
})


hl.config({
    binds = {
        movefocus_cycles_fullscreen = true,
    }
})

-- Window Rules
hl.window_rule({
    match = { class = ".*" },
    suppress_event = "maximize"
})
hl.window_rule({
    match = { class = "org.kde.*" },
    opacity = "0.85"
})
hl.window_rule({
    match = { class = "kitty" },
    no_blur = true
})
hl.window_rule({
    match = { class = "Alacritty" },
    no_blur = true
})
hl.window_rule({
    match = { class = "com.saivert.pwvucontrol" },
    float = true
})
hl.window_rule({
    match = { class = "org.fcitx.fcitx5-config-qt" },
    float = true
})
hl.window_rule({
    match = { class = "hyprland-share-picker" },
    float = true,
    size = {"monitor_w*0.5", "monitor_h*0.5"}
})
hl.window_rule({
    match = { title = "Sign in – Google accounts" },
    float = true
})

hl.window_rule({
    name = "keditfiletype",
    match = { class = "org.kde.keditfiletype" },
    float = true
})
hl.window_rule({
    name = "virt manager",
    match = { class = "virt-manager" },
    float = true,
    opacity = "0.85",
    move = {"monitor_w*0.15", "monitor_h*0.15"},
    size = {"monitor_w*0.7", "monitor_h*0.7"}
})
hl.window_rule({
    name = "virt machine",
    match = { title = ".*on QEMU/KVM" },
    opacity = "1.0",
    size = {"monitor_w*0.95", "monitor_h*0.93"}
})
hl.window_rule({
    name = "XDG desktop portal gtk",
    match = { class = "xdg-desktop-portal-gtk" },
    float = true,
    opacity = "0.85"
})
hl.window_rule({
    name = "kde presentation daemon",
    match = { class = "org.kde.kdeconnect.daemon" },
    float = true,
    no_blur = true,
    suppress_event = "fullscreen",
    size = {"monitor_w", "monitor_h"},
    move = {"0", "0"}
})
hl.window_rule({
    name = "libreoffice",
    match = { class = "soffice" },
    float = true,
    opacity = "0.9",
    size = {"monitor_w*0.7", "monitor_h*0.7"}
})

-- Blender File Picker
hl.window_rule({
    match = { title = "Blender" },
    float = true,
    size = {"monitor_w*0.6", "monitor_h*0.6"}
})

hl.window_rule({
    match = { title = "^([Pp][Ii][Cc][Tt][Uu][Rr][Ee][- ][Ii][Nn][- ][Pp][Ii][Cc][Tt][Uu][Rr][Ee])$" },
    float = true,
    pin = true,
    move = {"monitor_w*0.789", "monitor_h*0.2"},
    size = {"monitor_w*0.2", "monitor_h*0.18"}
})

-- Layer Rules

-- Sway Notification Center
hl.layer_rule({
    name            = "swaync-control-center",
    match           = { namespace = "swaync-control-center" },
    blur            = true,
    ignore_alpha    = 0.5,
})
hl.layer_rule({
    name            = "swaync-notification-window",
    match           = { namespace = "swaync-notification-window" },
    blur            = true,
    ignore_alpha    = 0.5,
})

-- Wofi
hl.layer_rule({
    name            = "wofi",
    match           = { namespace = "wofi" },
    blur            = true,
    ignore_alpha    = 0.5
})


local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd(terminal1))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({
    mode = "fullscreen",
    action = "toggle",
}))
--[[ hl.bind("Alt" .. " + F10", hl.dsp.window.fullscreen({
    mode = "maximize",
    action = "toggle",
}))]]
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pin())

-- Scrolling Binds
hl.bind(mainMod .. " + comma", hl.dsp.layout("move -col"))
hl.bind(mainMod .. " + period", hl.dsp.layout("move +col"))

hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.layout("swapcol r"))

hl.bind(mainMod .. " + bracketleft", hl.dsp.layout("colresize -conf"))
hl.bind(mainMod .. " + bracketright", hl.dsp.layout("colresize +conf"))

hl.bind(mainMod .. " + T", hl.dsp.layout("togglefit"))


-- Special Binds
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(fileManager .. " ~/Semesters/SEM_6"))

-- Emoji Evoke
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd("wofi-emoji"))

-- OBS Studio Controls
hl.bind(mainMod .. " + F10", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$"}))

-- Screenshots
hl.bind("print", hl.dsp.exec_cmd("hyprshot -m output -m active -o ~/Pictures/Screenshots"))
hl.bind("CTRL" .. " + print", hl.dsp.exec_cmd("hyprshot -m region -o ~/test1"))
hl.bind("CTRL" .. " + SHIFT + print", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

-- Brightness Control
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"))

-- Volume Control
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true , repeating = true})
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true , repeating = true})
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

-- Microphone Control
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("~/.config/hypr/bin/mic_mute.sh"), { locked = true })

-- Move Focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Swap Tiles
hl.bind(mainMod .. " + A", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + W", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + S", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + D", hl.dsp.window.move({ direction = "r" }))

-- Workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i})) -- switch to workspaces
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i })) -- move active window to workspace
end

-- Special workspace
hl.bind(mainMod .. " + Z",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Zoom in and out
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(hyprctl -j getoption cursor:zoom_factor | jq -r \'.float + 0.5\'"))
hl.bind(mainMod .. " + SHIFT + mouse_up", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(hyprctl -j getoption cursor:zoom_factor | jq -r \'.float - 0.5\'"))
hl.bind(mainMod .. " + CTRL + SHIFT + mouse_up", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor 1"))

-- playerctl Media Control
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("playerctl previous"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("playerctl next"))
