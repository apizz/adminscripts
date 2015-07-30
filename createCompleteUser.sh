#!/bin/bash
# Create entry under /Users
dscl . create /Users/seven_of_nine

# Set the users shell enviornment
dscl . create /Users/seven_of_nine UserShell /bin/bash

# Set the users full name
dscl . create /Users/seven_of_nine RealName "Seven of Nine"

# Select a unique User ID
dscl . create /Users/seven_of_nine UniqueID 502

# Set the users Group ID
dscl . create /Users/seven_of_nine PrimaryGroupID 1000

# Create the users home directory
dscl . create /Users/seven_of_nine NFSHomeDirectory /Local/Users/seven_of_nine

# Set the users password
dscl . passwd /Users/seven_of_nine PASSWORD

# Add the user to the admin group
dscl . append /Groups/admin GroupMembership seven_of_nine
