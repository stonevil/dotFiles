#!/usr/bin/env sh
# vim:ft=sh
# shellcheck source=/dev/null

_timezone_alpine_set() {
	TIMEZONE="US/Pacific"

	if command -v apk >/dev/null; then
		if [ "$(uname)" = "Linux" ]; then
			apk update && apk upgrade && apk --update add tzdata
			cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime
			echo $TIMEZONE >/etc/timezone
		fi
	else
		echo "Unsupported Linux. Only Alpine Linux is currently supported" && exit 1
	fi
}

_files_dot_install() {
	echo "Installing dotFiles into system"
	cp -Rf "$HOME"/.Files/src/.[a-zA-Z0-9]* "$HOME"/
}

_toolset_install() {
	_packages_install
}

_toolset_update() {
	_packages_update
}

_env_check() {
	if [ "$(uname)" = "Darwin" ] && [ -d "$HOME"/.homebrew ]; then
		export PATH=$HOME/.homebrew/bin:$HOME/.homebrew/sbin:$PATH
		# Set shell to zsh
		chsh -s /bin/zsh
	fi
	if [ "$(uname)" = "Linux" ]; then
		if command -v apk >/dev/null; then
			_repository_alpine_add
			# Set shell to zsh
			apk --update add git curl zsh shadow && usermod -s /bin/zsh "$(id -u -n)"
		else
			echo "Unsupported Linux. Only Alpine Linux is currently supported" && exit 1
		fi
	fi
}

_packages_install() {
	_env_check
	echo "Installing packages..."
	if [ -d "$HOME"/.Files ]; then
		if [ "$(uname)" = "Darwin" ]; then
			cd "$HOME" || exit
			if [ -d "$HOME"/.homebrew ]; then
				rm -Rf "$HOME"/.homebrew
			fi
			git clone https://github.com/Homebrew/brew.git "$HOME"/.homebrew && brew update && brew upgrade && brew upgrade --cask
			cd "$HOME"/.Files || exit
			brew bundle install && brew bundle cleanup
			cd "$HOME" || exit
		fi
		if [ "$(uname)" = "Linux" ]; then
			cd "$HOME"/.Files || exit
			apk update && apk upgrade && apk --update add $(paste -s -d ' ' Apkfile) || exit 1
			cd "$HOME" || exit
		fi
		if command -v kubectl-krew >/dev/null; then
			cd "$HOME"/.Files || exit
			kubectl-krew install <Krewfile
			cd "$HOME" || exit
		fi
		if command -v pip3 >/dev/null; then
			cd "$HOME"/.Files || exit
			pip3 install --upgrade pip
			pip3 install --upgrade --force-reinstall -r Pipfile
			cd "$HOME" || exit
		fi
		if command -v gem >/dev/null; then
			cd "$HOME"/.Files || exit
			xargs <Gemsfile gem install
			cd "$HOME" || exit
		fi
		if command -v go >/dev/null; then
			cd "$HOME"/.Files || exit
			if [ -f "$HOME"/.shellrc/golang ]; then
				source "$HOME"/.shellrc/golang
			fi
			while IFS= read -r line; do
				go get -u "$line"
			done <Gofile
			cd "$HOME" || exit
		fi
	else
		echo "$HOME/.Files directory is not available"
	fi
}

_packages_update() {
	if [ "$(uname)" = "Darwin" ]; then
		cd "$HOME"/.Files || exit
		brew update && brew upgrade && brew upgrade --cask && brew cleanup
		cd "$HOME" || exit
	fi
	if [ "$(uname)" = "Linux" ]; then
		cd "$HOME"/.Files || exit
		apk update && apk upgrade
		cd "$HOME" || exit
	fi
	if command -v nvim >/dev/null; then
		nvim +PlugInstall! +PlugClean! +PlugUpdate! +UpdateRemotePlugins +qall
	fi
	if command -v gcloud >/dev/null; then
		yes Y | gcloud components update
	fi
	if command -v kubectl-krew >/dev/null; then
		kubectl-krew update && kubectl-krew upgrade
	fi
	if command -v pip3 >/dev/null; then
		pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U
	fi
	if command -v gem >/dev/null; then
		cd "$HOME"/.Files || exit
		gem update $(gem outdated | cut -d ' ' -f 1)
		cd "$HOME" || exit
	fi
	if [ -d "$HOME"/.tmux/plugins ]; then
		for plugin in "$HOME"/.tmux/plugins/*; do
			if [ -d "$plugin" ]; then
				cd "$plugin" || exit
				if [ -d '.git' ]; then
					git pull
				fi
			fi
		done
		cd "$HOME" || exit
	fi
}

_packages_dump_list() {
	_tools_dev_check
	_env_check
	echo "Dumping list of installed packages"
	if [ -d "$HOME"/.Files ]; then
		cd "$HOME"/.Files || exit
		if [ "$(uname)" = "Darwin" ]; then
			brew bundle dump --force
		fi
		if [ "$(uname)" = "Linux" ]; then
			apk info >Apkfile
		fi
		if command -v kubectl-krew >/dev/null; then
			kubectl-krew list | awk '{print $1}' >Krewfile
		fi
		if command -v pip3 >/dev/null; then
			pip3 freeze --local >Pipfile
		else
			echo "pip3 command is not installed"
		fi
		if command -v ruby >/dev/null; then
			ruby -e 'puts Gem::Specification.all_names' | sed 's/-[0-9].*//' | sort -u >Gemsfile
		else
			echo "ruby command is not installed"
		fi
		cd "$HOME" || exit
	else
		echo "$HOME/.Files directory is not available"
		exit 1
	fi
}

_repository_alpine_add() {
	for reponame in "main" "community" "testing"; do
		grep -qF "http://dl-cdn.alpinelinux.org/alpine/edge/$reponame" /etc/apk/repositories || echo "http://dl-cdn.alpinelinux.org/alpine/edge/$reponame" >>/etc/apk/repositories
	done
}

_desktop_macos_set() {
	if [ "$(uname)" = "Darwin" ]; then
		# Activity Monitor
		defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
		defaults write com.apple.ActivityMonitor IconType -int 5
		defaults write com.apple.ActivityMonitor ShowCategory -int 0
		defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
		defaults write com.apple.ActivityMonitor SortDirection -int 0

		# Disk Utility
		defaults write com.apple.DiskUtility advanced-image-options -bool true

		# Dock: enable highlight hover effect for the grid view of a stack
		defaults write com.apple.dock mouse-over-hilite-stack -bool true

		# Dock: set the icon size of Dock items to 32 pixels
		defaults write com.apple.dock tilesize -int 32

		# Dock: change minimize/maximize window effect
		defaults write com.apple.dock mineffect -string "scale"

		# Dock: minimize windows into their application’s icon
		defaults write com.apple.dock minimize-to-application -bool true

		# Dock: enable spring loading for all Dock items
		defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

		# Dock: show indicator lights for open applications in the Dock
		defaults write com.apple.dock show-process-indicators -bool true

		# Dock: automatically hide and show
		defaults write com.apple.dock autohide -bool true

		# Dock: make icons of hidden applications translucent
		defaults write com.apple.dock showhidden -bool true

		# Mission Control: speed up animations
		defaults write com.apple.dock expose-animation-duration -float 0.1

		# Mission Control: group windows by application
		defaults write com.apple.dock expose-group-by-app -bool true

		# Mission Control: don’t automatically rearrange Spaces based on most recent use
		defaults write com.apple.dock mru-spaces -bool false

		# Hot corners
		# Possible values:
		#  0: no-op
		#  2: Mission Control
		#  3: Show application windows
		#  4: Desktop
		#  5: Start screen saver
		#  6: Disable screen saver
		#  7: Dashboard
		# 10: Put display to sleep
		# 11: Launchpad
		# 12: Notification Center
		# Top left screen corner → Mission Control
		defaults write com.apple.dock wvous-tl-corner -int 6
		defaults write com.apple.dock wvous-tl-modifier -int 0

		# Finder: disable desktop
		defaults write com.apple.finder CreateDesktop -bool false

		# Finder: disable window animations and Get Info animations
		defaults write com.apple.finder DisableAllAnimations -bool true

		# Finder: set Documents as the default location for new Finder windows
		defaults write com.apple.finder NewWindowTarget -string "PfDo"
		defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Documents/"

		# Finder: hide icons for hard drives, servers, and removable media on the desktop
		defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
		defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
		defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
		defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

		# Finder: hide hidden files by default
		defaults write com.apple.finder AppleShowAllFiles -bool false

		# Finder: show all filename extensions
		defaults write NSGlobalDomain AppleShowAllExtensions -bool true

		# Finder: show status bar
		defaults write com.apple.finder ShowStatusBar -bool true

		# Finder: show path bar
		defaults write com.apple.finder ShowPathbar -bool true

		# Finder: allow text selection in Quick Look
		defaults write com.apple.finder QLEnableTextSelection -bool true

		# Finder: display full POSIX path as Finder window title
		defaults write com.apple.finder _FXShowPosixPathInTitle -bool false

		# Finder: when performing a search, search the current folder by default
		defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

		# Finder: disable the warning when changing a file extension
		defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

		# Finder: enable spring loading for directories
		defaults write NSGlobalDomain com.apple.springing.enabled -bool true

		# Finder: remove the spring loading delay for directories
		defaults write NSGlobalDomain com.apple.springing.delay -float 0

		# Finder: avoid creating .DS_Store files on network volumes
		#defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

		# Finder: enable disk image verification
		defaults write com.apple.frameworks.diskimages skip-verify -bool false
		defaults write com.apple.frameworks.diskimages skip-verify-locked -bool false
		defaults write com.apple.frameworks.diskimages skip-verify-remote -bool false

		# Finder: disable automatically open a new Finder window when a volume is mounted
		defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool false
		defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool false
		defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool false

		# Finder: enable snap-to-grid for icons on the desktop and in other icon views
		/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
		/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
		/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

		# Finder: decrease grid spacing for icons on the desktop and in other icon views
		/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 54" ~/Library/Preferences/com.apple.finder.plist
		/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 54" ~/Library/Preferences/com.apple.finder.plist
		/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 54" ~/Library/Preferences/com.apple.finder.plist

		# Finder: decrease the size of icons on the desktop and in other icon views
		/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 32" ~/Library/Preferences/com.apple.finder.plist
		/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 32" ~/Library/Preferences/com.apple.finder.plist
		/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 32" ~/Library/Preferences/com.apple.finder.plist

		# Finder: use list view in all Finder windows by default. Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
		defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

		# Finder: enable the warning before emptying the Trash
		defaults write com.apple.finder WarnOnEmptyTrash -bool true

		# Finder: disable Empty Trash securely
		#defaults write com.apple.finder EmptyTrashSecurely -bool false

		# macOS: enable AirDrop over Ethernet and on unsupported Macs running Lion
		#defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

		# Finder: expand the following File Info panes:
		defaults write com.apple.finder FXInfoPanesExpanded -dict Comments -bool false Preview -bool false General -bool true OpenWith -bool true Privileges -bool false

		# Trackpad: enable “natural” scrolling
		defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

		# Sound: increase sound quality for Bluetooth headphones/headsets
		#defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

		# Keyboard: enable full keyboard access for all controls
		defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

		# Keyboaard: use scroll gesture with the Ctrl (^) modifier key to zoom
		defaults write com.apple.universalaccess closeViewScrollWheelToggle -int 0

		# Keyboard: enable press-and-hold for keys in favor of key repeat
		defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

		# Keyboard: set language and text formats
		# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with `Inches`, `en_GB` with `en_US`, and `true` with `false`.
		defaults write NSGlobalDomain AppleLanguages -array "en-GB" "en" "uk"
		#defaults write NSGlobalDomain AppleLocale -string "uk@currency=UAH"
		defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
		defaults write NSGlobalDomain AppleMetricUnits -bool true

		# Keyboard: enable auto-correct
		defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true

		# Mail: disable send and reply animations
		defaults write com.apple.mail DisableReplyAnimations -bool true
		defaults write com.apple.mail DisableSendAnimations -bool true

		# Mail: copy email addresses as `Foo Bar <foo@example.com>` instead of `foo@example.com` in Mail.app
		defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool true

		# Mail: display emails in threaded mode, sorted by date (oldest at the top)
		#defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "no"
		#defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "YES"
		#defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "last-saved-date"
		#defaults write com.apple.mail DraftsViewerAttributes -dict-add "SearchSortDescending" -string "YES"
		#defaults write com.apple.mail DraftsViewerAttributes -dict-add "SearchSortOrder" -string "rank"

		# Mail: enable inline attachments
		defaults write com.apple.mail DisableInlineAttachmentViewing -bool false

		# Mail: enable automatic spell checking
		defaults write com.apple.mail SpellCheckingBehavior -string "InlineSpellCheckingEnabled"

		# Messages: enable automatic emoji substitution
		defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnabledLegacy" -bool true
		defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool true

		# Messages: enable smart quotes
		defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool true
		# Messages: enable dash quotes
		defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticDashSubstitutionEnabled" -bool true

		# Messages: enable data and link detectors
		defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticDataDetectionEnabled" -bool true
		defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticLinkDetectionEnabled" -bool true

		# Messages: enable continuous spell checking
		defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool true
		defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "grammarCheckingEnabled" -bool true
		defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticSpellingCorrectionEnabled" -bool true

		# Messages: enable autoreplacement
		defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticTextReplacementEnabled" -bool true
		defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "smartInsertDeleteEnabled" -bool true

		# Menu bar, enable everything all
		defaults write com.apple.systemuiserver menuExtras -array \
			"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
			"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
			"/System/Library/CoreServices/Menu Extras/Battery.menu" \
			"/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
			"/System/Library/CoreServices/Menu Extras/Volume.menu" \
			"/System/Library/CoreServices/Menu Extras/Clock.menu"

		# Menu Extras: show remaining battery percentage; hide time
		defaults write com.apple.menuextra.battery ShowPercent -string "YES"

		# macOS: set highlight color to Red
		defaults write NSGlobalDomain AppleHighlightColor -string "1.000000 0.733333 0.721569 Red"

		# Finder: set sidebar icon size to medium
		defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

		# macOS: scrollbars
		# Possible values: `WhenScrolling`, `Automatic` and `Always`
		defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

		# macOS: expand save panel by default
		defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
		defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

		# macOS: save to disk (not to iCloud) by default
		#defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

		# macOS: expand print panel by default
		defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
		defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

		# macOS: automatically quit printer app once the print jobs complete
		defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

		# macOS: enable Resume system-wide
		defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool true

		# macOS: enable automatic termination of inactive apps
		defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

		# macOS: switch the Crash Reporter to use NC
		defaults write com.apple.CrashReporter UseUNC -int 1

		# macOS: set Help Viewer windows to non-floating mode
		defaults write com.apple.helpviewer DevMode -bool true

		# macOS: enable smart quotes
		defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool true

		# macOS: enable smart dashes
		defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool true

		# Safari: press Tab to highlight each item on a web page
		defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
		defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

		# Safari: show the full URL in the address bar (note: this still hides the scheme)
		defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

		# Safari: set Safari’s home page to `about:blank`
		defaults write com.apple.Safari HomePage -string "about:blank"

		# Safari: prevent Safari from opening ‘safe’ files automatically after downloading
		defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

		# Safari: hide Safari’s bookmarks bar by default
		defaults write com.apple.Safari ShowFavoritesBar -bool false

		# Safari: enable the Develop menu and the Web Inspector in Safari
		defaults write com.apple.Safari IncludeDevelopMenu -bool true
		defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
		defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

		# Safari: add a context menu item for showing the Web Inspector in web views
		defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

		# Safari: new tab and windows behavior
		defaults write com.apple.Safari NewTabBehavior -int 1
		defaults write com.apple.Safari NewWindowBehavior -int 1
		defaults write com.apple.Safari TabCreationPolicy -int 2

		# Safari: do not track
		defaults write com.apple.Safari SendDoNotTrackHTTPHeader -int 1

		# Safari: minimal font size
		defaults write com.apple.Safari WebKitMinimumFontSize -int 12

		# Safari: hide sidebar in new windows
		defaults write com.apple.Safari ShowSidebarInNewWindows -int 0

		# Safari: setup search engine
		#defaults write com.apple.Safari SearchProviderIdentifier -string "com.duckduckgo"
		#defaults write com.apple.Safari SearchProviderIdentifierMigratedToSystemPreference -int 1

		# Safari: restore at launch
		defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -int 1

		# macOS: require password immediately after sleep or screen saver begins
		defaults write com.apple.screensaver askForPassword -int 1
		defaults write com.apple.screensaver askForPasswordDelay -int 0

		# macOS: setup screensaver
		defaults -currentHost write com.apple.screensaver showClock -int 1
		defaults -currentHost write com.apple.screensaver idleTime -int 600

		# macOS: save screenshots to the desktop
		defaults write com.apple.screencapture location -string "${HOME}/Desktop"

		# macOS: save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
		defaults write com.apple.screencapture type -string "png"

		# macOS: disable shadow in screenshots
		defaults write com.apple.screencapture disable-shadow -bool true

		# TextEdit: use plain text mode for new TextEdit documents
		defaults write com.apple.TextEdit RichText -int 0

		# TextEdit: open and save files as UTF-8 in TextEdit
		defaults write com.apple.TextEdit PlainTextEncoding -int 4
		defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

		# TimeMachine: prevent from prompting to use new hard drives as backup volume
		defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

	fi
}
