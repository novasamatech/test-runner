#!/usr/bin/env bash
adb devices
# adb logcat -c
# adb logcat &

# Install debug app
adb -s emulator-5554 install app/androidTest/debug/app-debug-androidTest.apk

# Install instrumental tests
adb -s emulator-5554 install app/instrumentialTest/app-instrumentialTest.apk

# Run tests
adb shell am instrument -w -m -e debug false -e class 'io.novafoundation.nova.balances.BalancesIntegrationTest' io.novafoundation.nova.debug.test/io.qameta.allure.android.runners.AllureAndroidJUnitRunner
EXIT_STATUS=$?

# Export results
adb exec-out run-as io.novafoundation.nova.debug sh -c 'cd /data/data/io.novafoundation.nova.debug/files && tar cf - allure-results' > allure-results.tar

exit $EXIT_STATUS