function pbcopy --description 'Mac-compatible pbcopy using wl-copy'
    if test (count $argv) -gt 0
        wl-copy <$argv
    else
        wl-copy
    end
end
