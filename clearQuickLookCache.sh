#!/bin/bash
# Reset QuickLook plugins
qlmanage -r
# Reload QuickLook cache
qlmanage -r cache

# Remove QuickLook plists
rm ~/Library/Preferences/com.apple.quicklookconfig.plist
rm ~/Library/Preferences/com.apple.QuickLookDaemon.plist
killall cfprefsd >/dev/null
