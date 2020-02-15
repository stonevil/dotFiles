# vim:ft=sh :

# Git
if command -v git >/dev/null; then
	# review all files in a git-managed directory that are not yet added to git
	alias gv='vim $(git ls-files -o -X .gitignore)'
	# cleanup credentials cache
	alias glogout='git credential-cache exit'

	git_submodule_remove() {
		git config -f .git/config --remove-section submodule."$1"
		git config -f .gitmodules --remove-section submodule."$1"
		git rm --cached "$1"
		git commit -m "Remove $1 cookbook submodule"
		rm -rf "$1"
		rm -rf .git/modules/"$1"
	}
fi
