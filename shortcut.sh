###SHORTCUTSTART###
function shortcut() {
	HASH="###"
	STARTSTRING="${HASH}SHORTCUTSTART${HASH}"
	ENDSTRING="${HASH}SHORTCUTEND${HASH}"
	if [ -z "$1" ]; then
		echo "Usage: shortcut <shortcutname> <command>"
		echo "Example: shortcut gits git status"
		return
	fi
	if [ -z "$2" ]; then
		echo "Usage: shortcut <shortcutname> <command>"
		echo "Example: shortcut gits git status"
		return
	fi
	THISSCRIPTFILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)/$(basename "${BASH_SOURCE[0]}")"
	ALIAS="$1"
	shift
	ESCAPEDCOMMAND=$(echo "$@" | sed 's/\//\\\//g')
	ALIASCMD="alias $ALIAS=\"$ESCAPEDCOMMAND\""
	# add the alias before the endstring
	sed -i "/^$ENDSTRING$/i $ALIASCMD" $THISSCRIPTFILE
	echo "Added alias: $ALIASCMD"
	source $THISSCRIPTFILE
	echo "Sourced $THISSCRIPTFILE"
	echo "Done"
}
function shortcut-list() {
	ANSI_BOLD_BLUE="\e[1;34m"
	ANSI_BOLD_WHITE="\e[1;37m"
	ANSI_BOLD_GREEN="\e[1;32m"
	ANSI_BOLD_CYAN="\e[1;36m"
	ANSI_RESET="\e[0m"
	echo -e "${ANSI_BOLD_BLUE}Shortcuts:${ANSI_RESET}"
	HASH="###"
	STARTSTRING="${HASH}SHORTCUTSTART${HASH}"
	ENDSTRING="${HASH}SHORTCUTEND${HASH}"
	THISSCRIPTFILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)/$(basename "${BASH_SOURCE[0]}")"
	# get all lines between start and end string
	LINES=$(sed -n "/$STARTSTRING/,/$ENDSTRING/p" $THISSCRIPTFILE)
	while read -r LINE; do
		if [[ $LINE =~ ^alias ]]; then # if line starts with alias
			WITHOUTALIAS=$(echo $LINE | sed 's/alias //g')
			ALIAS=$(echo $WITHOUTALIAS | cut -d= -f1)
			COMMAND=$(echo $WITHOUTALIAS | cut -d= -f2 | sed 's/^"//g' | sed 's/"$//g')
			echo -e "${ANSI_BOLD_CYAN}$ALIAS${ANSI_RESET} ${ANSI_BOLD_WHITE}=>${ANSI_RESET} ${ANSI_BOLD_GREEN}$COMMAND${ANSI_RESET}"
		fi
	done <<<"$LINES"
}
function shortcut-remove() {
	ANSI_BOLD_CYAN="\e[1;36m"
	ANSI_BOLD_RED="\e[1;31m"
	ANSI_RESET="\e[0m"
	if [ -z "$1" ]; then
		echo "Usage: shortcut-remove <shortcutname>"
		echo "Example: shortcut-remove gits"
		return
	fi
	HASH="###"
	STARTSTRING="${HASH}SHORTCUTSTART${HASH}"
	ENDSTRING="${HASH}SHORTCUTEND${HASH}"
	THISSCRIPTFILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)/$(basename "${BASH_SOURCE[0]}")"
	# get all lines between start and end string
	LINES=$(sed -n "/$STARTSTRING/,/$ENDSTRING/p" $THISSCRIPTFILE)
	while read -r LINE; do
		if [[ $LINE =~ ^alias ]]; then # if line starts with alias
			WITHOUTALIAS=$(echo $LINE | sed 's/alias //g')
			ALIAS=$(echo $WITHOUTALIAS | cut -d= -f1)
			if [ "$ALIAS" == "$1" ]; then
				sed -i "/$LINE/d" $THISSCRIPTFILE
				echo -e "Removed ${ANSI_BOLD_CYAN}$ALIAS${ANSI_RESET}"
				source $THISSCRIPTFILE
				echo "Sourced $THISSCRIPTFILE"
				echo "Done"
				return
			fi
		fi
	done <<<"$LINES"
}
###SHORTCUTEND###
