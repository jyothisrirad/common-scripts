# $HOME/GitHub/mine/editors
function cde {
    cdgm "editors/$1"
}

alias cded=cde

function cdgat {
    cde "atom/$1"
}

function cdem {
    cde "emacs/$1"
}

function cdvim {
    cde "vim/$1"
}
