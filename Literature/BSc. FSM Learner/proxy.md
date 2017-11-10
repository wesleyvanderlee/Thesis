# Proxy

Real device is connected. Can be used to retrieve API requests.

mitmproxy (dump) was used, because it is scriptable. Works perfect except that it needs a pin to sign certificate.

--> solution in emulator. Saving state

installed cert works fine, does not need to get (un)locked (except at startup).

Installing 9292.apk yields error:
`adb -s emulator-5554 install 9292.apk
138 KB/s (4766922 bytes in 33.584s)
Failure [INSTALL_FAILED_NO_MATCHING_ABIS: Failed to extract native libraries, res=-113]
`
Reason: INSTALL_FAILED_NO_MATCHING_ABIS is when you are trying to install an app that has native libraries and it doesn't have a native library for your cpu architecture.

Reconfigure for another CPU architecture
