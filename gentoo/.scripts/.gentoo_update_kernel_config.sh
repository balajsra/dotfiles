#!/usr/bin/env bash
KERNEL_SAVED_CONFIG_PATH="/etc/portage/savedconfig/sys-kernel"
KERNEL_EBUILD_PATH="/var/db/repos/gentoo/sys-kernel/gentoo-kernel"

LAST_KERNEL=$(basename $(sudo ls ${KERNEL_SAVED_CONFIG_PATH}/gentoo-kernel-* | sort -V | tail -n 1))
NEW_KERNEL_EBUILD=$(basename $(sudo ls ${KERNEL_EBUILD_PATH}/gentoo-kernel-*.ebuild | sort -V | tail -n 1))
NEW_KERNEL="${NEW_KERNEL_EBUILD%.*}"

NEW_KERNEL_BUILD_DIR="/var/tmp/portage/sys-kernel/${NEW_KERNEL}/work/modprep"

echo "###############################"
echo "# Preparing New Kernel Source #"
echo "###############################"
ebuild ${KERNEL_EBUILD_PATH}/${NEW_KERNEL_EBUILD} clean configure

pushd ${NEW_KERNEL_BUILD_DIR} > /dev/null

echo "##############################"
echo "# Copying Last Kernel Config #"
echo "##############################"
cp ${KERNEL_SAVED_CONFIG_PATH}/${LAST_KERNEL} .config

echo "###############################"
echo "# Updating Last Kernel Config #"
echo "###############################"
make oldconfig
make listnewconfig

echo "############################"
echo "# Saving New Kernel Config #"
echo "############################"
cp .config ${KERNEL_SAVED_CONFIG_PATH}/${NEW_KERNEL}

popd > /dev/null

echo "####################################"
echo "# Script Complete, close window... #"
echo "####################################"
