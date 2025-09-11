# Enable tap-to-click for the trackpad and show the correct state in System Preferences
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1

# Disable the .DS file creation
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show the path bar in the Finder
defaults write com.apple.finder "ShowPathbar" -bool "true" && killall Finder

# Show hidden files in the Finder
defaults write com.apple.finder "AppleShowAllFiles" -bool "true" && killall Finder

# Keep folders on top in Finder
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true" && killall Finder

# Keep folders on top on Desktop
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true" && killall Finder

# Disable press and hold for key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Apply the settings
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
