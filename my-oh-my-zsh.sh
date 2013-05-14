############################################
#
#		My Oh My ZSH
#
#		Features
#		 - A simple way of separately maintaining themes for oh-my-zsh.
#		 - Customize color palettes for themes.
#
#		Notes:
#		 - Requires Oh My ZSH: https://github.com/robbyrussell/oh-my-zsh
#
############################################

_my_oh_my_zsh_banner() {
	
	echo '\033[38;5;045m''+-----------------+------------------+-------------------+----------------------+' '\033[0m'
	echo '\033[38;5;044m''|   __  __        |      ___  _      |     __  __        |     _______ _  _ _   |' '\033[0m'
	echo '\033[38;5;039m''|  |  \/  |_  _    \    / _ \| |_     \   |  \/  |_  _    \   |_  / __| || | |   \' '\033[0m'
	echo '\033[38;5;038m'"|  | |\/| | || |    >  | (_) | ' \     >  | |\/| | || |    >   / /\__ \ __ |_|    >" '\033[0m'
	echo '\033[38;5;033m''|  |_|  |_|\_, |   /    \___/|_||_|   /   |_|  |_|\_, |   /   /___|___/_||_(_)   /' '\033[0m'
	echo '\033[38;5;032m''|          |__/   |                  |            |__/   |                      |' '\033[0m'
	echo '\033[38;5;027m''+-----------------+------------------+-------------------+----------------------+' '\033[0m'
	
}

#
# Check for updates
#
NOW=$( date "+%s" )
LASTUPDATEFILE="${HOME}/.my-oh-my-zsh/.lastupdate"
if [ ! -f $HOME/.my-oh-my-zsh/.lastupdate ]; then
	echo $NOW > $HOME/.my-oh-my-zsh/.lastupdate
fi
LASTUPDATE=$( cat $HOME/.my-oh-my-zsh/.lastupdate )
if [ "$DISABLE_AUTO_UPDATE" != "true" ] && [ $NOW -gt $[ $LASTUPDATE + 864000 ] ]
then
	echo `date "+%s"` > $HOME/.my-oh-my-zsh/.lastupdate
	cd $HOME/.my-oh-my-zsh
	git remote update > /dev/null 2>&1
	if [ -n "$( git status -uno | grep behind )" ]; then
		echo -n 'Type Y to update My Oh My ZSH: Y/n: '
		read x
		if [ "$x" = Y ] || [ "$x" = y ]; then
			_my_oh_my_zsh_banner
			git pull
	echo '\033[38;5;027m''+-----------------+------------------+-------------------+----------------------+' '\033[0m'
		fi
	fi
	cd -
fi

#
#	Link my theme file(s) into place
#
for i in $HOME/.my-oh-my-zsh/*.zsh-theme; do
	if [ ! -f $HOME/.oh-my-zsh/themes/$(basename $i) ]; then
		echo -n "Linking $(basename $i) as ${HOME}/.oh-my-zsh/themes/$(basename ${i})..."
		ln -s $i $HOME/.oh-my-zsh/themes/$(basename $i)
		if [ -f $HOME/.oh-my-zsh/themes/$(basename $i) ]; then
			echo "OK"
		else
			echo "FAIL"
		fi
	fi
done

#
#	If there is a theme config file, read it.
#
if [ -f $HOME/.my-oh-my-zsh/$ZSH_THEME.custom ]; then
	. $HOME/.my-oh-my-zsh/$ZSH_THEME.custom
fi


