function openrabup {
    cdgo OpenRA
    git checkout bleed -q
    git pull origin bleed -q
    mastn=$(comno)
    specn=$(vere openra-bleed)
    comm=$(loge)
    specm=$(come openra-bleed)

    if [[ $specn == $mastn ]]; then
         printf "OpenRA Bleed is up to date!\n"
    else
         printf "Updating OBS repo openra-bleed.\n"
         sed -i -e "s/$specn/$mastn/g" $OBSH/openra-bleed/openra-bleed.spec
         sed -i -e "s/$specm/$comm/g" $OBSH/openra-bleed/openra-bleed.spec
         cdobsh openra-bleed
         osc ci -m "Bumping $specn->$mastn"
         /usr/local/bin/openra-build
    fi
}

function ra2up {
    cdgo ra2
    git pull origin master -q
    mastn=$(comno)
    specn=$(vere openra-ra2)
    comm=$(loge)
    specm=$(come openra-ra2)

    if [[ $specn == $mastn ]]; then
         printf "OpenRA RA2 is up to date!\n"
    else
         sed -i -e "s/$specn/$mastn/g" $OBSH/openra-ra2/openra-ra2.spec
         sed -i -e "s/$specm/$comm/g" $OBSH/openra-ra2/openra-ra2.spec
         cdobsh openra-ra2
         osc ci -m "Bumping $specn->$mastn"
    fi
}

# Dark Reign update
function drup {
    cdgo DarkReign
    git pull origin master -q
    mastn=$(comno)
    specn=$(vere openra-dr)
    comm=$(loge)
    specm=$(come openra-dr)

    if [[ $specn == $mastn ]]; then
         printf "OpenRA Dark Reign is up to date!\n"
    else
         sed -i -e "s/$specn/$mastn/g" $OBSH/openra-dr/openra-dr.spec
         sed -i -e "s/$specm/$comm/g" $OBSH/openra-dr/openra-dr.spec
         cdobsh openra-dr
         osc ci -m "Bumping $specn->$mastn"
    fi
}

# Dark Reign update
function racup {
    cdgo raclassic
    git pull origin master -q
    mastn=$(comno)
    specn=$(vere openra-raclassic)
    comm=$(loge)
    specm=$(come openra-raclassic)

    if [[ $specn == $mastn ]]; then
         printf "OpenRA RA Classic is up to date!\n"
    else
         sed -i -e "s/$specn/$mastn/g" $OBSH/openra-raclassic/openra-raclassic.spec
         sed -i -e "s/$specm/$comm/g" $OBSH/openra-raclassic/openra-raclassic.spec
         cdobsh openra-raclassic
         osc ci -m "Bumping $specn->$mastn"
    fi
}

function uRAup {
    cd $HOME/GitHub/others/uRA
    git pull origin master -q
    # OpenRA latest engine version
    enlv=$(cat mod.config | grep '^ENGINE\_VERSION' | cut -d '"' -f 2)
    # OpenRA engine version in spec file
    enpv=$(cat $HOME/OBS/home:fusion809/openra-ura/openra-ura.spec | grep "define engine\_version" | cut -d ' ' -f 3)
    mastn=$(git rev-list --branches master --count)
    specn=$(cat $HOME/OBS/home:fusion809/openra-ura/openra-ura.spec | grep "Version\:" | sed 's/Version:\s*//g')
    comm=$(git log | head -n 1 | cut -d ' ' -f 2)
    specm=$(cat $HOME/OBS/home:fusion809/openra-ura/openra-ura.spec | grep "define commit" | cut -d ' ' -f 3)

    if [[ $specn == $mastn ]]; then
         printf "OpenRA Red Alert Unplugged mod is up to date\!\n"
    else
         sed -i -e "s/$specn/$mastn/g" $HOME/OBS/home:fusion809/openra-ura/openra-ura.spec
         sed -i -e "s/$specm/$comm/g" $HOME/OBS/home:fusion809/openra-ura/openra-ura.spec
         if ! [[ $enpv == $enlv ]]; then
              sed -i -e "s/$enpv/$enlv/g" $HOME/OBS/home:fusion809/openra-ura/openra-ura.spec
              make
              tar czvf $HOME/OBS/home:fusion809/openra-ura/engine.tar.gz engine
         fi
         cd $HOME/OBS/home:fusion809/openra-ura
         if ! [[ $enpv == $enlv ]]; then
              osc ci -m "Bumping $specn->$mastn; engine $enpv->$enlv"
         else
              osc ci -m "Bumping $specn->$mastn; engine version is unchanged."
         fi
    fi
}

alias uraup=uRAup