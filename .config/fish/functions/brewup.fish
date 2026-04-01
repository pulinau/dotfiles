function brewup --wraps='brew upgrade; brew cleanup; brew doctor' --description 'Runs brew upgrade, clean, & doctor'
    brew upgrade
    brew cleanup
    brew doctor $argv
end
