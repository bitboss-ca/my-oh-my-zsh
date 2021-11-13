#!/usr/local/bin/zsh
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

#
#	Banner
#
_my_oh_my_zsh_banner() {
	MOMZ_BANNER_STYLE_FG="38;5"
	MOMZ_BANNER_STYLE_BG="48;5"	
	MOMZ_TAG_HOST="\033[${MOMZ_BANNER_STYLE_BG};${DAVE_COLOR_HOST_BG}m\e[${MOMZ_BANNER_STYLE_FG};${DAVE_COLOR_HOST_FG}m"
	MOMZ_TAG_USER="\033[${MOMZ_BANNER_STYLE_BG};${DAVE_COLOR_USER_BG}m\033[${MOMZ_BANNER_STYLE_FG};${DAVE_COLOR_USER_FG}m"
	MOMZ_TAG_DIR="\033[${MOMZ_BANNER_STYLE_BG};${DAVE_COLOR_DIR_BG}m\033[${MOMZ_BANNER_STYLE_FG};${DAVE_COLOR_DIR_FG}m"
	MOMZ_TAG_GIT="\033[${MOMZ_BANNER_STYLE_BG};${DAVE_COLOR_GIT_BG}m\033[${MOMZ_BANNER_STYLE_FG};${DAVE_COLOR_GIT_FG}m"
	echo "${MOMZ_TAG_HOST}                   ${MOMZ_TAG_USER}                   ${MOMZ_TAG_DIR}                    ${MOMZ_TAG_GIT}                       "'\033[0m'
	echo "${MOMZ_TAG_HOST}    __  __         ${MOMZ_TAG_USER}      ___  _       ${MOMZ_TAG_DIR}     __  __         ${MOMZ_TAG_GIT}     _______ _  _ _    "'\033[0m'
	echo "${MOMZ_TAG_HOST}   |  \/  |_  _     ${MOMZ_TAG_USER}    / _ \| |_      ${MOMZ_TAG_DIR}   |  \/  |_  _     ${MOMZ_TAG_GIT}   |_  / __| || | |    "'\033[0m'
	echo "${MOMZ_TAG_HOST}   | |\/| | || |     ${MOMZ_TAG_USER}  | (_) | ' \      ${MOMZ_TAG_DIR}  | |\/| | || |     ${MOMZ_TAG_GIT}   / /\__ \ __ |_|     "'\033[0m'
	echo "${MOMZ_TAG_HOST}   |_|  |_|\_, |    ${MOMZ_TAG_USER}    \___/|_||_|    ${MOMZ_TAG_DIR}   |_|  |_|\_, |    ${MOMZ_TAG_GIT}   /___|___/_||_(_)    "'\033[0m'
	echo "${MOMZ_TAG_HOST}           |__/    ${MOMZ_TAG_USER}                   ${MOMZ_TAG_DIR}            |__/    ${MOMZ_TAG_GIT}                       "'\033[0m'
	echo "${MOMZ_TAG_HOST}                   ${MOMZ_TAG_USER}                   ${MOMZ_TAG_DIR}                    ${MOMZ_TAG_GIT}                       "'\033[0m'
}

#
#	Utilities
#
alias prompts='PREVPROMPT=$( readlink .my-oh-my-zsh/dave.custom | cut -d'.' -f 3 ); cd ~/.my-oh-my-zsh; for i in dave.custom.*; do echo $i | cut -d'.' -f 3; unlink dave.custom; ln -s $i dave.custom; source ~/.zshrc > /dev/null; print -P $PROMPT; echo "\n========\n"; done; unlink dave.custom; ln -s dave.custom.$PREVPROMPT dave.custom; source ~/.zshrc > /dev/null; cd ~ > /dev/null 2>&1'
reprompt() {
	cd ~/.my-oh-my-zsh;
	[ -L dave.custom ] && unlink dave.custom
	ln -s dave.custom.$1 dave.custom
	source ~/.zshrc > /dev/null
	cd ~ > /dev/null 2>&1
}

#
# Check for updates
#
NOW=$( date "+%s" )
MOMZ_LASTUPDATEFILE="${HOME}/.my-oh-my-zsh/.lastupdate"
if [ ! -f $HOME/.my-oh-my-zsh/.lastupdate ]; then
	echo $NOW > $MOMZ_LASTUPDATEFILE
fi
MOMZ_LASTUPDATE=$( cat $MOMZ_LASTUPDATEFILE )
if [ "$MOMZ_DISABLE_AUTO_UPDATE" != "true" ] && [ $NOW -gt $[ $MOMZ_LASTUPDATE + 864000 ] ]
then
	echo `date "+%s"` > $MOMZ_LASTUPDATEFILE
	cd $HOME/.my-oh-my-zsh
	git remote update > /dev/null 2>&1
	# if [ -n "$( git status -uno | grep behind )" ]; then
	if [ 1 ]; then
		echo -n 'Type Y to update My Oh My ZSH: Y/n: '
		read x
		if [ "$x" = Y ] || [ "$x" = y ]; then
			_my_oh_my_zsh_banner
			git pull
			# echo '\033[38;5;027m''+-----------------+------------------+-------------------+----------------------+' '\033[0m'
		fi
	fi
	cd - > /dev/null
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


