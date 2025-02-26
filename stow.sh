#!/bin/bash
set -euo pipefail

# Helper function to log a command that will be executed, like `set +x`
# would do, then execute it and returns its exit code.
run_cmd() {
	echo "+ $*"
	"$@"
	return $?
}

# Array to hold packages that will be stowed
PACKAGES=()

# Populate the no-fold list
for dir in */; do
	package=${dir%/} # Remove trailing slash
	PACKAGES+=("$package")
done

# Notify the user of the actions that will be performed.
echo "The following actions will be performed:"
echo " - The following packages will be stowed: ${PACKAGES[*]}"
echo
read -r -p "Type 'y' and press ENTER to continue, or any other key to abort: " confirm
if [[ "$confirm" != "y" ]]; then
	echo "Aborting."
	exit 1
fi
echo

# Now loop over the no-fold list to stow with --no-folding
for package in "${PACKAGES[@]}"; do
	run_cmd stow "$package"
done
