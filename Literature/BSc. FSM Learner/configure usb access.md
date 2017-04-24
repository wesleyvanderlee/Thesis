# ADB

Upon execution of the project, the missing script invokes an adb shell command. The phone used OnePlusX wasn't detected by adb, hence the commands issued by the [missing script](https://github.com/wesleyvanderlee/Thesis/blob/master/Literature/BSc.%20FSM%20Learner/make_dump.sh) fail.

The phone was set up with the following instructions: http://bernaerts.dyndns.org/android/339-android-oneplustwo-oneplusx-enable-adb-mtp-detection-ubuntu-trusty. Website was a slow load. Downloaded the website [here](https://github.com/wesleyvanderlee/Thesis/blob/master/Literature/BSc.%20FSM%20Learner/sources/OnePlus%20Two%20&%20OnePlus%20X%20-%20Enable%20ADB%20and%20MTP%20under%20Ubuntu.pdf) to be sure.

After following the article and unlocking the device, the device could be recognized:
`wesley@ubuntu:~$ adb devices
List of devices attached
88915990	device
`

Trying the first command from the missing script: `adb shell uiautomator dump` does not create the XML file `/storage/emulated/legacy/window_dump.xml` on the device. It also does not prompt any error messages. An error message is shown when the command is executed in an interactive shell:
`
wesley@ubuntu:~$ adb shell
shell@OnePlus:/ $ uiautomator dump
Killed 137|
shell@OnePlus:/ $
`

This error is extensively discussed [here](https://github.com/dtmilano/AndroidViewClient/issues/175) and is present because uiautomator is obsolete.

After debugging and trial and error, it appears that the output file is stored to `/sdcard/window_dump.xml` whereas the missing script tries to pull the dump-file from `/storage/emulated/legacy/window_dump.xml`.
