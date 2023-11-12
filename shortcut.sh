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
###SHORTCUTEND###
