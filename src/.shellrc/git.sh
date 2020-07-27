#!/usr/bin/env bash
# vim:ft=sh :

# Git
if command -v git >/dev/null; then
	alias gad='git add'
	alias gAD='git add -A'
	alias gpu='git push'
	alias glg='git log'
	alias gst='git status'
	alias gdf='git diff'
	alias gco='git commit -v'
	alias gca='git commit -a -v'
	alias gbr='git branch'
	alias gch='git cheikout'
	alias gmv='git mv'
	alias grm='git rm'
	alias ggr='git grep'
	alias grad='git remote add'
	alias grrm='git remote rm'
	alias gpl='git pull'
	alias gcl='git clone'
	alias gta='git tag -a -m'
	alias gfl='git reflog'

	# leverage an alias from the ~/.gitconfig
	alias ghi='git hist'
	alias glg1='git lg1'
	alias glg2='git lg2'
	alias glg='git lg'

	# review all files in a git-managed directory that are not yet added to git
	alias gv='vim $(git ls-files -o -X .gitignore)'

	# cleanup credentials cache
	alias glogout='git credential-cache exit'

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
