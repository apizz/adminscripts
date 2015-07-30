#!/bin/bash
# terminal-notifier needs to be installed and password-less logins set up via ssh keys
ssh username@remotehost "/usr/local/bin/terminal-notifier \
  -title "\"Title of Notification\"" \
	-subtitle "\"Subtitle here\"" \
	-message "\"Detailed message information here\"" \
	-sound Purr \
	-execute "\"echo yourCommandToExecute \"""
