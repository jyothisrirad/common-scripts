function git-branch {
    git rev-parse --abbrev-ref HEAD
}

# Push changes
## Minimal version
function pushm {
    git add --all                                        # Add all files to git
    git commit -m "$1"                                   # Commit with message = argument 1
    git push origin $(git-branch)                        # Push to the current branch
}

## Update common-scripts
function cssubup {
    if [[ $1 = common ]] && ! `echo $PWD | grep "$SCR/common-scripts" > /dev/null 2>&1` && [[ -d "$SCR/$1-scripts" ]] ; then
         printf "Updating common-scripts repository.\n"
         pushd $SCR/$1-scripts
    else
         pushd $SCR/$1-scripts/Shell/common-scripts
    fi

    git pull origin master

    if ! [[ $1 = common ]]; then
         pushd ..
         pushm "Updating common-scripts submodule"
         popd
    fi

    popd
}

function update-common {
    printf "Updating common-scripts submodules and main repo.\n"
    cssubup arch
    cssubup centos
    cssubup common
    cssubup debian
    cssubup fedora
    cssubup gentoo
    cssubup mageia
    cssubup nixos
    cssubup opensuse
    cssubup pclinuxos
    cssubup pisi
    cssubup sabayon
    cssubup slackware
    cssubup void
}

# Complete push    
function push {
    if `printf "$PWD" | grep 'AUR' > /dev/null 2>&1`; then
         mksrcinfo
    fi

    pushm "$1"

    if `echo $PWD | grep "$HOME/Shell" > /dev/null 2>&1`; then
         szsh
    elif `echo $PWD | grep "$FS" > /dev/null 2>&1` && `cat /etc/os-release | grep -i Fedora > /dev/null 2>&1`; then
         szsh
    elif `echo $PWD | grep "$AS" > /dev/null 2>&1` && `cat /etc/os-release | grep -i Arch > /dev/null 2>&1`; then
         szsh
    elif `echo $PWD | grep "$GS" > /dev/null 2>&1` && `cat /etc/os-release | grep -i Gentoo > /dev/null 2>&1`; then
         szsh
    elif `echo $PWD | grep "$DS" > /dev/null 2>&1` && `cat /etc/os-release | grep -i "Debian\|Ubuntu" > /dev/null 2>&1`; then
         szsh
    elif `echo $PWD | grep "$VS" > /dev/null 2>&1` && `cat /etc/os-release | grep -i Void > /dev/null 2>&1`; then
         szsh
    elif `echo $PWD | grep "$OS" > /dev/null 2>&1` && `cat /etc/os-release | grep -i openSUSE > /dev/null 2>&1`; then
         szsh
    elif `echo $PWD | grep "$NS" > /dev/null 2>&1` && `cat /etc/os-release | grep -i NixOS > /dev/null 2>&1`; then
         szsh
    elif `echo $PWD | grep "$PLS" > /dev/null 2>&1` && `cat /etc/os-release | grep -i PCLinuxOS > /dev/null 2>&1`; then
         szsh
    elif `echo $PWD | grep "$CS" > /dev/null 2>&1` && `cat /etc/os-release | grep -i CentOS > /dev/null 2>&1`; then
         szsh
    fi

    # Update common-scripts dirs
    if `echo $PWD | grep "$HOME/Shell/common-scripts" > /dev/null 2>&1`; then
         if ! `echo $SHELL | grep zsh > /dev/null 2>&1`; then
              read -p "Do you want to update common-scripts submodules and the main common-scripts repo (if not already up-to-date) now? [y/n] " yn
         else
              read "yn?Do you want to update common-scripts submodules and the main common-scripts repo (if not already up-to-date) now? [y/n] "
         fi

         case $yn in
              [Yy]* ) update-common;;
              [Nn]* ) printf "OK, it's your funeral. Run update-common if you change your mind.\n" ;; 
              * ) printf "Please answer y or n.\n" ; ...
         esac
    fi
}

# Estimate the size of the current repo
# Taken from http://stackoverflow.com/a/16163608/1876983
function gitsize {
    git gc
    git count-objects -vH
}

# Git shrink
# Taken from http://stackoverflow.com/a/2116892/1876983
function gitsh {
    git reflog expire --all --expire=now
    git gc --prune=now --aggressive
}

function pushss {
    push "$1" && gitsh && gitsize
}
