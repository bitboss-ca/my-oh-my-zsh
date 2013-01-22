#
#		Dave ZSH Prompt Theme
#		 - Inspired by Powerline theme by FreeAgent
#
if [ "$DAVE_RIGHT_B" = "" ]; then
  DAVE_RIGHT_B=%D{%H:%M:%S}
fi

if [ "$DAVE_RIGHT_A" = "" ]; then
  DAVE_RIGHT_A=%D{%Y-%m-%d}
fi

DAVE_CURRENT_PATH="%d"

if [ "$DAVE_FULL_CURRENT_PATH" = "" ]; then
  DAVE_CURRENT_PATH="%1~"
fi


DAVE_GIT_INFO_LEFT=""
DAVE_GIT_INFO_RIGHT="%F{red}"$''"%F{black}%K{red}"$'$(git_prompt_info)'" %f"
if [ "$DAVE_SHOW_GIT_ON_RIGHT" = "" ]; then
    DAVE_GIT_INFO_LEFT=$'$(git_prompt_info)'
#    DAVE_GIT_INFO_LEFT="%F{red}"$''"%F{black}%K{red}"$'$(git_prompt_info)'" %f"
    DAVE_GIT_INFO_RIGHT=""
fi


############################################
#	Subversion Prompt
############################################
function dave_svn_prompt_info {

	wd=`pwd -P`

	SVN_REVISION_STRING=$(svn info 2> /dev/null | grep '^Revision*') || return
	SVN_REVISION=$(echo $SVN_REVISION_STRING | sed 's/Revision: //' ) || return
	SVN_RELATIVE_DIR=$(svn info | grep '^Working Copy Root Path*' | sed 's/Working Copy Root Path: //' 2> /dev/null) || return
	SVN_RELATIVE_DIR_ESCAPED=$(echo $SVN_RELATIVE_DIR | sed 's/\//\\\//g')
	SVN_REPO_PATH="$( echo $wd | sed "s/${SVN_RELATIVE_DIR_ESCAPED}//g") "

	# this is the slowest test of the bunch
	change_count=`svn status | grep "^?\|\!\|M\|A" | wc -l | awk '{print $1}'`
	if [ "${change_count}" != '0' ]; then
		svn_change="$ZSH_THEME_SVN_PROMPT_DIRTY"
	else
		svn_change="$ZSH_THEME_SVN_PROMPT_CLEAN"
	fi

	# Set the Prompt String	
	echo "$ZSH_THEME_SVN_PROMPT_PREFIX$SVN_REPO_PATH[2,-1]"'r'"$SVN_REVISION$svn_change$ZSH_THEME_SVN_PROMPT_SUFFIX"
}
#
#	This puts the literal string $(dave_svn_prompt_info) right into the prompt, meaning it will run at every prompt
#
DAVE_SVN_INFO_LEFT=$'$(dave_svn_prompt_info)'


############################################
#	New Colors Config
############################################
if [ -z $DAVE_COLOR_HOST_BG ]; then
	DAVE_COLOR_HOST_BG='012'
fi
if [ -z $DAVE_COLOR_HOST_FG ]; then
	DAVE_COLOR_HOST_FG='252'
fi
if [ -z $DAVE_COLOR_USER_BG ]; then
	DAVE_COLOR_USER_BG='004'
fi
if [ -z $DAVE_COLOR_USER_FG ]; then
	DAVE_COLOR_USER_FG='252'
fi
if [ -z $DAVE_COLOR_DIR_BG ]; then
	DAVE_COLOR_DIR_BG='022'
fi
if [ -z $DAVE_COLOR_DIR_FG ]; then
	DAVE_COLOR_DIR_FG='252'
fi
if [ -z $DAVE_COLOR_GIT_BG ]; then
	DAVE_COLOR_GIT_BG='054'
fi
if [ -z $DAVE_COLOR_GIT_FG ]; then
	DAVE_COLOR_GIT_FG='252'
fi
if [ -z $DAVE_COLOR_END_BG ]; then
	DAVE_COLOR_END_BG='000'
fi

############################################
#	New Colors Setup
############################################
DAVE_HOST_BG=%K{$DAVE_COLOR_HOST_BG}
DAVE_HOST_FG=%F{$DAVE_COLOR_HOST_FG}
DAVE_HOSTUSER_BG=%K{$DAVE_COLOR_USER_BG}
DAVE_HOSTUSER_FG=%F{$DAVE_COLOR_HOST_BG}
DAVE_USER_BG=%K{$DAVE_COLOR_USER_BG}
DAVE_USER_FG=%F{$DAVE_COLOR_USER_FG}
DAVE_USERDIR_BG=%K{$DAVE_COLOR_DIR_BG}
DAVE_USERDIR_FG=%F{$DAVE_COLOR_USER_BG}
DAVE_DIR_BG=%K{$DAVE_COLOR_DIR_BG}
DAVE_DIR_FG=%F{$DAVE_COLOR_DIR_FG}
DAVE_DIRGIT_BG=%K{$DAVE_COLOR_GIT_BG}
DAVE_DIRGIT_FG=%F{$DAVE_COLOR_DIR_BG}
DAVE_GIT_BG=%K{$DAVE_COLOR_GIT_BG}
DAVE_GIT_FG=%F{$DAVE_COLOR_GIT_FG}
DAVE_GITEND_BG=%K{$DAVE_COLOR_END_BG}
DAVE_GITEND_FG=%F{$DAVE_COLOR_GIT_BG}
DAVE_END_BG=%K{$DAVE_COLOR_END_BG}
DAVE_END_FG=%F{$DAVE_COLOR_DIR_BG}

############################################
#	Other Colors
############################################
DAVE_COLOR_BG_GRAY=%K{240}
DAVE_COLOR_BG_LIGHT_GRAY=%K{240}
DAVE_COLOR_BG_WHITE=%K{255}
DAVE_COLOR_FG_GRAY=%F{240}
DAVE_COLOR_FG_LIGHT_GRAY=%F{240}
DAVE_COLOR_FG_WHITE=%F{255}
GIT_DIRTY_COLOR=%F{133}
GIT_CLEAN_COLOR=%F{118}
GIT_PROMPT_INFO=%F{012}

############################################
#
# Git Prompt Setup
#
############################################
#
#	The $'\u0008' below is a backspace character.  It backs up one char over the END connector, and
#		then we overwrite it with the GIt connector instead.
#
ZSH_THEME_GIT_PROMPT_PREFIX=$'\u0008'"$DAVE_DIRGIT_BG$DAVE_DIRGIT_FG"$'\u25B6'"$DAVE_GIT_BG$DAVE_GIT_FG "
ZSH_THEME_GIT_PROMPT_SUFFIX=" $DAVE_GITEND_BG$DAVE_GITEND_FG"$'\u25B6'
ZSH_THEME_GIT_PROMPT_DIRTY=" $GIT_DIRTY_COLOR✘"
ZSH_THEME_GIT_PROMPT_CLEAN=" $GIT_CLEAN_COLOR✔"
ZSH_THEME_GIT_PROMPT_ADDED="%F{082}✚%f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{166}✹%f"
ZSH_THEME_GIT_PROMPT_DELETED="%F{160}✖%f"
ZSH_THEME_GIT_PROMPT_RENAMED="%F{220]➜%f"
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{082]═%f"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{190]✭%f"

############################################
#
# Subversion Prompt Setup
#
############################################
#
#	The $'\u0008' below is a backspace character.  It backs up one char over the END connector, and
#		then we overwrite it with the GIt connector instead.
#
ZSH_THEME_SVN_PROMPT_PREFIX=$'\u0008'"$DAVE_DIRGIT_BG$DAVE_DIRGIT_FG"$'\u25B6'"$DAVE_GIT_BG$DAVE_GIT_FG "
ZSH_THEME_SVN_PROMPT_SUFFIX=" $DAVE_GITEND_BG$DAVE_GITEND_FG"$'\u25B6'
ZSH_THEME_SVN_PROMPT_DIRTY=" $GIT_DIRTY_COLOR✘"
ZSH_THEME_SVN_PROMPT_CLEAN=" $GIT_CLEAN_COLOR✔"



DAVE_SEC1_BG=%K{green}
DAVE_SEC1_FG=%F{green}
DAVE_SEC1_TXT=%F{black}
if [ "$DAVE_DETECT_SSH" != "" ]; then
  if [ -n "$SSH_CLIENT" ]; then
    DAVE_SEC1_BG=%K{red}
    DAVE_SEC1_FG=%F{red}
    DAVE_SEC1_TXT=%F{white}
  fi
fi
PROMPT="$DAVE_HOST_BG$DAVE_HOST_FG ${(C)$(hostname -s)} $DAVE_HOSTUSER_BG$DAVE_HOSTUSER_FG"$'\u25B6'"$DAVE_USER_BG$DAVE_USER_FG %n $DAVE_USERDIR_BG$DAVE_USERDIR_FG"$'\u25B6'"$DAVE_DIR_BG$DAVE_DIR_FG $DAVE_CURRENT_PATH $DAVE_END_BG$DAVE_END_FG▶$DAVE_GIT_INFO_LEFT$DAVE_SVN_INFO_LEFT %f%k"
if [ "$DAVE_NO_BLANK_LINE" = "" ]; then
    PROMPT="
"$PROMPT
fi

RPROMPT=$DAVE_GIT_INFO_RIGHT$DAVE_COLOR_FG_WHITE$'\u25C0'"%f$DAVE_COLOR_BG_WHITE $DAVE_COLOR_FG_GRAY$DAVE_RIGHT_B "$'\u25C0'"%f%k$DAVE_COLOR_BG_GRAY$DAVE_COLOR_FG_WHITE $DAVE_RIGHT_A %f%k"
