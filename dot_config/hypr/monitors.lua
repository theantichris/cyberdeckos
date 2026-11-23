local vars = require("variables")

hl.monitor({
    output   = vars.monitors.laptop,
    mode     = "3840x2400@240",
    position = "0x0",
    scale    = 2,
    bitdepth = 10,
    cm       = "hdr",
})

hl.monitor({
    output   = vars.monitors.external,
    mode     = "3440x1440@240",
    position = "-3440x0",
    scale    = 1,
    bitdepth = 10,
    cm       = "hdr",
    vrr      = 2,
})
