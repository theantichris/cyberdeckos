set -gx EDITOR ms
set -gx VISUAL ms
set -gx BROWSER brave-origin

function fish_greeting
    if command -q fastfetch
        fastfetch
    end
end
