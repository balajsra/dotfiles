#!/usr/bin/env bash
echo "################################"
echo "# Syncing Package Repositories #"
echo "################################"
eix-sync -a

echo "##########################"
echo "# Updating Live Packages #"
echo "##########################"
emerge @smart-live-rebuild

echo "###############################"
echo "# Updating Versioned Packages #"
echo "###############################"
emerge --update --deep --newuse --with-bdeps=y --verbose-conflicts --backtrack=100 @world
