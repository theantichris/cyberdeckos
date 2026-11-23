function __deck_git_status
    git rev-parse --is-inside-work-tree >/dev/null 2>&1
    or return

    set -l branch (git symbolic-ref --short HEAD 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)
    set -l markers ''

    git diff --quiet 2>/dev/null
    or set markers "$markers ~"

    git diff --cached --quiet 2>/dev/null
    or set markers "$markers +"

    set -l untracked (git ls-files --others --exclude-standard 2>/dev/null)
    if set -q untracked[1]
        set markers "$markers ?"
    end

    set -l ahead_behind (git rev-list --count --left-right '@{upstream}...HEAD' 2>/dev/null)
    if test -n "$ahead_behind"
        set -l behind (printf '%s\n' "$ahead_behind" | cut -f1)
        set -l ahead (printf '%s\n' "$ahead_behind" | cut -f2)

        if test "$behind" -gt 0
            set markers "$markers ⇣$behind"
        end
        if test "$ahead" -gt 0
            set markers "$markers ⇡$ahead"
        end
    end

    printf ' [%s%s]' "$branch" "$markers"
end

function fish_prompt
    set -l last_status $status
    set -l left_part '╭─'

    if test $last_status -ne 0
        set left_part (printf '%s✗ %s ' "$left_part" "$last_status")
    end

    if test -n "$SSH_CONNECTION"; or fish_is_root_user
        set left_part (printf '%s%s@%s ' "$left_part" "$USER" "$hostname")
    end

    if test -n "$VIRTUAL_ENV"
        set left_part (printf '%s(%s) ' "$left_part" (basename "$VIRTUAL_ENV"))
    end

    if test -f go.mod; and command -q go
        set -l version (go version | awk '{print $3}')
        if test -n "$version"
            set left_part (printf '%s[%s] ' "$left_part" "$version")
        end
    end

    if test -f package.json; and command -q node
        set -l version (node -v 2>/dev/null)
        if test -n "$version"
            set left_part (printf '%s[%s] ' "$left_part" "$version")
        end
    end

    set -l directory (string replace -r "^$HOME" '~' "$PWD")
    set left_part (printf '%s%s' "$left_part" "$directory")

    set -l git_part (__deck_git_status)
    if test -n "$git_part"
        set left_part (printf '%s%s' "$left_part" "$git_part")
    end

    set -l right_part " \uf017  "(date '+%H:%M:%S')
    set -l left_len (string length -- "$left_part")
    set -l right_len (string length -- "$right_part")
    set -l fill_width (math "$COLUMNS - $left_len - $right_len - 2")

    set -l dots ''
    if test $fill_width -gt 0
        set dots (string repeat -n $fill_width '·')
    end

    printf '%s %s%s\n' "$left_part" "$dots" "$right_part"
    printf '╰─❯❯❯ '
end

function fish_right_prompt
end
