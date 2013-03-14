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
	cat <<EOT
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=+
|   __  __         ___  _      __  __        _______ _  _ _   |
|  |  \/  |_  _   / _ \| |_   |  \/  |_  _  |_  / __| || | |  |
|  | |\/| | || | | (_) | ' \  | |\/| | || |  / /\__ \ __ |_|  |
|  |_|  |_|\_, |  \___/|_||_| |_|  |_|\_, | /___|___/_||_(_)  |
|          |__/                       |__/                    |
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=+
EOT
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
	CURDIR=`pwd`
	cd $HOME/.my-oh-my-zsh
	git remote update > /dev/null 2>&1
	if [ -n "$( git status -uno | grep behind )" ]; then
		echo -n 'Type Y to update My Oh My ZSH: Y/n: '
		read x
		if [ "$x" = Y ] || [ "$x" = y ]; then
			_my_oh_my_zsh_banner
			git pull
			echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
		fi
	fi
	cd $CURDIR
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


