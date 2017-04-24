args=($@)
FILENAME=${args[0]}
adb shell uiautomator dump
echo ${FILENAME}
adb pull /storage/emulated/legacy/window_dump.xml alphabet/window_dumps/$FILENAME  
