#!/bin/sh
# vim:ft=sh
# shellcheck source=/dev/null

# TODO
# Add gem install
# Add go get some packages
# lazydock and lazygit for Alpine
# Add edge and testing and community repo

_check_internet_connection() {
	echo "Check Internet connection"
	if command -v curl >/dev/null; then
		"$(curl -sL -w "%{http_code}\n" "http://www.github.com/" -o /dev/null)" -eq 200 && return 0
	else
		echo "curl command is not installed. Internet connection is not tested" && return 0
	fi
}

_check_dev_tools() {
	if ! command -v git >/dev/null; then
		if _check_internet_connection; then
			if [ "$(uname)" = "Darwin" ]; then
				xcode-select --install || exit 1
			fi
			if [ "$(uname)" = "Linux" ]; then
				apk add --update git || exit 1
			fi
		fi
	fi
}

_clone_dot_files_repo() {
	if [ ! -d "$HOME"/.Files ]; then
		if _check_internet_connection; then
			cd "$HOME" || exit 1
			git clone https://github.com/stonevil/dotFiles.git "$HOME"/.Files || exit 1
		fi
	fi
}

# Preflight check
_check_dev_tools
if [ ! -f "$HOME"/.Files/framework.sh ]; then
	_clone_dot_files_repo
else
	. "$HOME"/.Files/framework.sh || exit 1
fi

# Main
if [ -d "$HOME"/.Files ]; then
	case "$1" in
	dump)
		_dump_packages
		;;
	pkgs)
		_install_toolset
		;;
	dot)
		_install_dot_files
		;;
	*)
		_install_dot_files
		_install_toolset
		;;
	esac
fi
