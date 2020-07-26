# vim:ft=sh :

darkmode() {
	defaults write $(osascript -e 'id of app "'"$@"'"' | tr -d '\n' | tr -d '\r') NSRequiresAquaSystemAppearance -bool FALSE
	terminal-notifier -title "The Empire Strikes Back" -subtitle 'Embrace the Dark Side, Luke' -appIcon /System/Library/PrivateFrameworks/PhotoLibraryPrivate.framework/Versions/A/Frameworks/PhotoPrintProduct.framework/Versions/A/Resources/alert-yellow_large.tiff -sound Hero -ignoreDnD -message "Use your $@"
}
