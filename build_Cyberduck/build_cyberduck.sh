#!/bin/bash

# Path relative to this script
PATH=`pwd`

# Bundle identifer to use for Cyberduck 
BUNDLE_ID="edu.abc.cyberduck.pkg"

# Location of vmware application, assuming default location 
APP="Cyberduck.app"

# The version number of the app
VERSION="7.0.1"

# What to call the installer package
INSTALLER_PKG="Cyberduck-${VERSION}.pkg"

# Developer ID must be provided or package creation will fail since it cannot be signed
DEVELOPER_ID="Developer ID Installer: Your Developer ID"

# Package the UTC Installer
/usr/bin/pkgbuild --install-location "/Applications" \
  --sign "${DEVELOPER_ID}" \
  --identifier "${BUNDLE_ID}" \
  --component "${APP}" \
  --quiet \
  "${PATH}/${INSTALLER_PKG}"



