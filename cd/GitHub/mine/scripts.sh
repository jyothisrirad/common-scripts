# Scripts
function cdsc {
	cdgm "scripts/$1"
}

function cdas {
	cdsc "arch-scripts/$1"
}

function cdces {
	cdsc "centos-scripts/$1"
}

function cdcs {
	cdsc "common-scripts/$1"
}

function cdcsu {
	cdcs "usr/local/bin"
}

function cdds {
	cdsc "debian-scripts/$1"
}

function cdfs {
	cdsc "fedora-scripts/$1"
}

function cdfrs {
	cdsc "freebsd-scripts/$1"
}

function cdgs {
	cdsc "gentoo-scripts/$1"
}

function cdjs {
	cdsc "JScripts/$1"
}

function cdms {
	cdsc "mageia-scripts/$1"
}

function cdos {
	cdsc "opensuse-scripts/$1"
}

function cdpisi {
	cdsc "pisi-scripts/$1"
}

function cdpy {
	cdsc "python-scripts/$1"
}

function cdss {
	cdsc "sabayon-scripts/$1"
}

function cdsls {
	cdsc "slackware-scripts/$1"
}

function cdzt {
	cdsc "zsh-theme/$1"
}

alias cdzsh=cdzt
alias cdzsht=cdzt
alias cdzst=cdzt

function cdaqi {
	cdsc "atom-quick-install/$1"
}

function cdgn {
	cdsc "GNU_Octave/$1"
}

function cdgpl {
	cdsc "PyMOL-scripts/$1"
}

alias cdgpml=cdgpl
