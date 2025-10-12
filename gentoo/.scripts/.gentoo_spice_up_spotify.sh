#!/usr/bin/env bash
echo "############################################"
echo "# (Re)Installing Spotify and Spicetify-CLI #"
echo "############################################"
emerge media-sound/spotify app-misc/spicetify-cli-bin::sravan-overlay

echo "#############################################"
echo "# Changing Permissions on Spotify Directory #"
echo "#############################################"
chmod a+wr -R /opt/spotify

echo "####################################"
echo "# Applying Spicetify Configuration #"
echo "####################################"
spicetify backup apply

echo "####################################"
echo "# Script Complete, close window... #"
echo "####################################"
