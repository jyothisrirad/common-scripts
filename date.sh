function datep {
    sudo tune2fs -l /dev/$1 | grep created | sed 's/.*created\:\s*//g'
}
