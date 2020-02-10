#!/bin/sh
# vim:ft=sh

# TODO
# Add gem install
# Add go get some packages
# lazydock and lazygit for Alpine
# Add edge and testing and community repo

cloneDotFilesRepo() {
	if [ ! -d "$HOME"/.Files ]; then
		if [ "$(curl -sL -w "%{http_code}\n" "http://www.github.com/" -o /dev/null)" -eq 200 ]; then
			cd "$HOME" || exit
			git clone https://github.com/stonevil/dotFiles.git "$HOME"/.Files
			cd "$HOME"/.Files || exit
			git pull --recurse-submodules
			cd "$HOME" || exit
		fi
	else
		echo "$HOME/.Files directory already installed"
		pullDotFilesRepo
	fi
}

pullDotFilesRepo() {
	if [ ! -d "$HOME"/.Files ]; then
		if [ "$(uname)" = "Linux" ]; then
			apk add --update git
		fi
		cd "$HOME"/.Files || exit
		git pull
		cd "$HOME" || exit
	fi
}

installDotFiles() {
	echo "Installing dotFiles into system"
	cp -Rf "$HOME"/.Files/src/.[a-zA-Z0-9]* "$HOME"/
}

installPackages() {
	echo "Installing packages..."
	if [ -d "$HOME"/.Files ]; then
		if [ "$(uname)" = "Darwin" ]; then
			cd "$HOME" || exit
			if [ -d "$HOME"/.homebrew ]; then
				rm -Rf "$HOME"/.homebrew
			fi
			git clone https://github.com/Homebrew/homebrew.git "$HOME"/.homebrew && brew update && brew upgrade && brew cask upgrade
			cd "$HOME"/.Files || exit
			brew bundle install && brew bundle cleanup
			cd "$HOME" || exit
		fi
		if [ "$(uname)" = "Linux" ]; then
			cd "$HOME"/.Files || exit
			apk update && apk upgrade && apk --update add $(paste -s -d ' ' Apkfile)
			cd "$HOME" || exit
		fi
		if command -v pip3 >/dev/null; then
			cd "$HOME"/.Files || exit
			pip3 install --upgrade pip
			pip3 install --upgrade --force-reinstall --no-cache-dir -r Pipfile
			cd "$HOME" || exit
		fi
	else
		echo "$HOME/.Files directory is not available"
	fi
}

dumpPackages() {
	echo "Dumping list of installed packages"
	if [ -d "$HOME"/.Files ]; then
		cd "$HOME"/.Files || exit
		if [ "$(uname)" = "Darwin" ]; then
			brew bundle dump --force
		fi
		if [ "$(uname)" = "Linux" ]; then
			apk info >Apkfile
		fi
		if command -v pip3 >/dev/null; then
			pip3 freeze --local >Pipfile
		else
			echo "pip3 command is not installed"
		fi
		if command -v ruby >/dev/null; then
			ruby -e 'puts Gem::Specification.all_names' >Gemsfile
		else
			echo "ruby command is not installed"
		fi
		cd "$HOME" || exit
	else
		echo "$HOME/.Files directory is not available"
		exit 1
	fi
}

addRepository() {
	for reponame in "main" "community" "testing"; do
		grep -qF "http://dl-cdn.alpinelinux.org/alpine/edge/$reponame" /etc/apk/repositories || echo "http://dl-cdn.alpinelinux.org/alpine/edge/$reponame" >>/etc/apk/repositories
	done
}

# Preflight check
if [ "$(uname)" = "Darwin" ] && [ -d "$HOME"/.homebrew ]; then
	export PATH=$HOME/.homebrew/bin:$PATH
	# Set shell to zsh
	chsh -s /bin/zsh
fi
if [ "$(uname)" = "Linux" ]; then
	if ! command -v apk >/dev/null; then
		echo "Unsupported Linux. Only Alpine Linux is currently supported" && exit 1
	fi
else
	addRepository
	# Set shell to zsh
	apk --update add git curl zsh shadow && usermod -s /bin/zsh "$(id -u -n)"
fi

# Main
if [ -d "$HOME"/.Files ]; then
	case "$1" in
	dump)
		dumpPackages
		;;
	pkgs)
		installPackages
		;;
	*)
		installDotFiles
		installPackages
		;;
	esac
else
	pullDotFilesRepo && installDotFiles && installPackages
fi
