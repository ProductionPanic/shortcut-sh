#!/bin/bash
BASHTYPE=$(basename $SHELL)
RCFILE=~/.$BASHTYPE"rc"
THISSCRIPTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
SCRIPTDIR=$THISSCRIPTDIR/shortcut.sh
FINDSTRING="###SHORTCUTSTART###"
FINDENDSTRING="###SHORTCUTEND###"
function deleteLines {
	sed -i "/$FINDSTRING/,/$FINDENDSTRING/d" $RCFILE
}
function deleteIfExist {
	if grep -q "$FINDSTRING" "$RCFILE"; then
		echo "Found in $RCFILE"
		echo "Deleting..."
		deleteLines
		echo "Deleted"
	fi
}

deleteIfExist
# add to rc file
echo "Adding to $RCFILE"
cat $SCRIPTDIR >>$RCFILE
echo "Added to $RCFILE"

echo "Sourcing $RCFILE"
source $RCFILE
echo "Sourced $RCFILE"
echo "Done"
