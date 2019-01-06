#!/bin/bash

# Clear Working Dirs
rm -rf input/* output/*
adb pull /system/framework/framework.jar input/
adb pull /system/build.prop input/

# Patch Signature Spoof
python main.py

# Push Patch to device
adb root
adb remount
adb push output/ManualMode/framework.jar /system/framework/framework.jar

# Push Necessary apks
##adb shell mkdir /system/priv-app/PrebuiltGmsCore /system/priv-app/GoogleServicesFramework /system/priv-app/Phonesky

adb shell rm /system/priv-app/Phonesky/Phonesky.apk && adb push MicroG/Phonesky.apk /system/priv-app/Phonesky/Phonesky.apk

adb shell rm /system/priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk && adb push MicroG/PrebuiltGmsCore.apk /system/priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk

adb shell rm /system/priv-app/GoogleServicesFramework/GoogleServicesFramework.apk && adb push MicroG/GoogleServicesFramework.apk /system/priv-app/GoogleServicesFramework/GoogleServicesFramework.apk

# Fix Permissions after Installation
##adb shell chmod 755 /system/priv-app/GoogleServicesFramework /system/priv-app/PrebuiltGmsCore /system/priv-app/Phonesky

# Push Ad-Blocker Host file
adb push MicroG/hosts /system/etc/hosts

# For older SDKs only
##adb push MicroG/Phonesky.apk /system/app/Phonesky.apk
##adb push MicroG/PrebuiltGmsCore.apk /system/app/PrebuiltGmsCore.apk
##adb push MicroG/GoogleServicesFramework.apk /system/app/GoogleServicesFramework.apk
##adb shell chmod 644 /system/app/*

# Clear Google Accounts if necessary
rm /data/system_de/0/accounts_de.db
rm /data/system_de/0/accounts_de.db-journal
rm /data/system_ce/0/accounts_ce.db
rm /data/system/sync/accounts.xml

# Clear Cache/Dalvik
adb shell rm -rf /data/dalvik-cache
adb reboot fastboot && wait 10
fastboot format cache
fastboot continue
