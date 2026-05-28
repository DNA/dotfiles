local wezterm = require("wezterm")
local mux = wezterm.mux

local config = {
    -- Misc configuration
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,

    -- Font configuration
    font_size = 12,
    cell_width = 1.1,
    line_height = 1.2,
    font_rules = {
        {
            intensity = "Normal",
            font = wezterm.font({
                family = "Monaspace Neon Var",
                weight = 200,
                harfbuzz_features = { "calt", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "ss09", "liga" },
            }),
        },
        {
            intensity = "Half",
            font = wezterm.font({
                family = "Monaspace Neon Var",
                weight = 500,
                harfbuzz_features = { "calt", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "ss09", "liga" },
            }),
        },
        {
            intensity = "Bold",
            font = wezterm.font({
                family = "Monaspace Neon Var",
                weight = 800,
                harfbuzz_features = { "calt", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "ss09", "liga" },
            }),
        },
    },

    -- Color configuration
    color_scheme = "Catppuccin Mocha (DNA)",

    inactive_pane_hsb = {
        saturation = 0.5,
        brightness = 0.3,
    },

    -- Window and background configuration
    window_background_opacity = 1,
    window_decorations = "RESIZE",
    window_padding = {
        left = 30,
        right = 30,
        top = 20,
        bottom = 20,
    },
    -- background = {
    --     {
    --         source = { Color = 'black' },
    --         width = "100%",
    --         height = "100%",
    --     },
    --     {
    --         source = { File = '/Users/lprado/Pictures/konachan-336959.jpg' },
    --         -- source = { File = "/Users/lprado/Pictures/konachan-242058.jpg" },
    --         vertical_align = "Middle",
    --         horizontal_align = "Center",
    --         opacity = 0.2,
    --     },
    -- },

    -- Key bindings
    keys = {
        -- Better split panes commands
        { key = "|",          mods = "CTRL|SHIFT|ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
        { key = "_",          mods = "CTRL|SHIFT|ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

        -- Activate Shift + enter for newline on Claude Code
        { key = "Enter",      mods = "SHIFT",          action = wezterm.action { SendString = "\x1b\r" } },

        -- Move between words with option +  arrows
        { key = "LeftArrow",  mods = "OPT",            action = wezterm.action({ SendKey = { mods = 'OPT', key = 'b' } }) },
        { key = "RightArrow", mods = "OPT",            action = wezterm.action({ SendKey = { mods = 'OPT', key = 'f' } }) },

        -- Use ^/ instead of ^a on tmux
        { key = "/",          mods = "CTRL",           action = wezterm.action({ SendKey = { mods = 'CTRL', key = 'a' } }) },

    },

    -- The following keys change click to ctrl+click on links
    mouse_bindings = {
        {
            event = { Up = { streak = 1, button = "Left" } },
            mods = "NONE",
            action = wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection'
        },
        {
            event = { Up = { streak = 1, button = "Left" } },
            mods = "CTRL",
            action = wezterm.action.OpenLinkAtMouseCursor,
        },
        {
            event = { Down = { streak = 1, button = "Left" } },
            mods = "CTRL",
            action = wezterm.action.Nop,
        },
    },
}

-- Spawn a new window with a maximized terminal
wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():toggle_fullscreen() -- Original example used maximize() but it wasn't working on MacOS
    wezterm.sleep_ms(10)
end)

return config
