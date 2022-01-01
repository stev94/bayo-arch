conky.config = {
    alignment = 'top_left',
    background = true,
    cpu_avg_samples = 2,
    default_color = 'D64161',
    color1 = 'cdcdcd',
    double_buffer = true,
    font = 'Fira Sans:noral:size=14',
    override_utf8_locale = true,
    text_buffer_size = 1024,
    draw_shades = false,
    gap_x = 10,
    gap_y = 41,
    minimum_height = 5,
    minimum_width = 231,
    maximum_width = 400,
    xinerama_head = 4,
    net_avg_samples = 2,
    no_buffers = true,
    out_to_console = false,
    out_to_stderr = false,
    extra_newline = false,
    own_window = true,
    own_window_type = 'override',
    own_window_class = 'Conky',
    own_window_transparent = true,
    stippled_borders = 0,
    uppercase = false,
    use_spacer = 'none',
    show_graph_scale = false,
    show_graph_range = false,
    update_interval = 1.0,
    use_xft = true
}

conky.text = [[
${alignc}${font Mono:size=16}${color1}${time %B %Y}${color}
${font Mono:size=15}${color1}  Su Mo Tu We Th Fr Sa${color}
${font Mono:size=15}${execpi 3600 ~/.config/conky/cal.lua}
${alignc}${execpi 1800 ~/.config/conky/weather.lua}
${voffset 10}${alignc}${execpi 1800 ~/.config/conky/moonphase.lua}
]]
