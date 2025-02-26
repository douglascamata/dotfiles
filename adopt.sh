#!/bin/bash
set -euo pipefail

# Helper function to log a command that will be executed, like `set +x`
# would do, then execute it and returns its exit code.
run_cmd() {
	echo "+ $*"
	"$@"
	return $?
}

# This script automates adding a dotfile into a package directory,
# then running stow adopt.
#
# Usage: ./add_dotfile.sh <package_name> <path_to_dotfile>
# Example: ./add_dotfile.sh dotfiles ~/.config/.zshrc

# Check that both arguments are provided.
if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <package_name> <path_to_dotfile>"
	exit 1
fi

# Assign arguments.
PACKAGE="$1"
FILE_INPUT="$2"

# Expand the file path (handles both '~' and full paths).
if [[ "$FILE_INPUT" == ~* ]]; then
	FILE=$(eval echo "$FILE_INPUT")
else
	FILE="$FILE_INPUT"
fi

# Verify that the file is inside the user's home directory.
if [[ "$FILE" != "$HOME"* ]]; then
	echo "Error: The file must be inside your home directory."
	exit 1
fi

# Compute the path relative to $HOME.
REL_PATH="${FILE#"$HOME"/}"

# Define the target path in the package folder.
TARGET="./$PACKAGE/$REL_PATH"

# Notify the user of the actions that will be performed.
echo "The following actions will be performed:"
echo " - If '$FILE' is a file, it will be adopted with 'stow --adopt."
echo " - If '$FILE' is a folder, it will be copied to '$TARGET' (as long as it was empty)."
echo " - '$FILE' will be deleted."
echo " - The '$PACKAGE' package will be stowed, symlinking '$FILE' to '$TARGET'."
echo
read -r -p "Type 'y' and press ENTER to continue, or any other key to abort: " confirm
if [[ "$confirm" != "y" ]]; then
	echo "Aborting."
	exit 1
fi
echo

# Backup the original file (if it exists) by copying it to the same directory with a .bak postfix.
if [ -f "$FILE" ]; then
	run_cmd stow --adopt "$PACKAGE" "$FILE"
# Backup the original folder (if it exists) by copying it to the same directory with a .bak postfix.
elif [ -d "$FILE" ]; then
	echo "• Backing up $FILE ..."
	run_cmd mkdir -p "$TARGET"
	# If there are files in $FILE, exit
	if [ "$(ls -A "$TARGET")" ]; then
		echo "• Error: $TARGET is not empty. Aborting."
		exit 1
	fi
	run_cmd cp -R "$FILE"/* "$TARGET"
	run_cmd rm -rf "$FILE"
	stow "$PACKAGE"
else
	echo "• Warning: $FILE does not exist. Skipping backup."
fi

echo "• Checking symlink."
run_cmd ls -l "$FILE"

echo "• Done."
