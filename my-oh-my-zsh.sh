
#
#	Link my theme file into place
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
