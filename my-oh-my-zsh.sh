############################################
#
#		My Oh My ZSH
#
#		Features
#		 - A simple way of separately maintaining themes for oh-my-zsh.
#		 - Ccustomize color palettes for themes.
#
#		Notes:
#		 - Requires Oh My ZSH: https://github.com/robbyrussell/oh-my-zsh
#
############################################

#
# Check for updates on load...
#
if [ "$DISABLE_AUTO_UPDATE" != "true" ]
then
	cd $HOME/.my-oh-my-zsh
	git remote update > /dev/null
	if [ -n "$( git status -uno | grep behind )" ]; then
		echo -n 'Type Y to update My oh my ZSH: Y/n: '
		read x
		if [ "$x" = Y ] || [ "$x" = y ]; then
			git pull
		fi
	fi
	cd
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


