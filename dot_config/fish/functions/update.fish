function update
    sudo pacman -Syu; or return

    if command -q shelly
        shelly; or return
    end

    if command -q go-global-update
        go-global-update; or return
    end

    if command -q cargo-install-update
        cargo install-update -a; or return
    end

    if command -q gh
        gh extension upgrade --all; or return
    end
end
