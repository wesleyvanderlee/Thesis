# Notes about Android Studio

https://developer.android.com/studio/run/index.html

## Steps

### Configure Emulator
1. Install Android studio
2. Create and manage virtual devices
https://developer.android.com/studio/run/managing-avds.html#about

An Android Virtual Device (AVD) definition lets you define the characteristics of an Android phone, tablet, Android Wear, or Android TV device that you want to simulate in the Android Emulator. The AVD Manager helps you easily create and manage AVDs. An AVD contains a hardware profile, system image, storage area, skin, and other properties.

**Hardware profile**
The hardware profile defines the characteristics of a device as shipped from the factory. The AVD Manager comes preloaded with certain hardware profiles, such as Nexus phone devices, and you can define and import hardware profiles as needed. You can override some of the settings in your AVD, if needed.

To effectively test an application, one should create an AVD that models each device type that your app is designed to support.

**System image**
The AVD Manager helps you choose a system image for your AVD by providing recommendations. It also lets you download system images, some with add-on libraries, like Google APIs, which your app might require. **x86 system images run the fastest in the emulator**. Android Wear and Android TV devices tend to run best (and have the largest installed base) on recent releases, while users of Android phones and tablets tend to use slightly older releases, as shown in the API level dashboards.

We recommend that you create an AVD for each API level that your app could potentially support based on the <uses-sdk> setting in your manifest. For example, you might want to test with all API levels that are equal to and higher than the minSdkVersion setting. By testing with API levels higher than required by your app, you ensure app forward-compatibility when users download system updates.

**Storage area**
The AVD has a dedicated storage area on your development machine. It stores the device user data, such as installed apps and settings, as well as an emulated SD card. If needed, you can **use the AVD Manager to wipe user data**, so the device has the same data as if it were new.

**Skin**
An emulator skin specifies the appearance of a device. The AVD Manager provides some predefined skins. You can also define your own, or use skins provided by third parties.

### Creating the emulator

Start emulator with
`/home/wesley/Documents/sdk/android-studio/bin/studio.sh`
Start AVD manager (icon in toolbar) and create new avd (Nexus 6P/ Nougat x86 Android 7.1.1)

Process problem:
Could not create a new AVD. During AVD installation an error was thrown. Looking at the logs of Android Studio (`/home/wesley/.AndroidStudio2.3/system/log/idea.log`), it contained the following error :
`
2017-04-21 02:11:53,860 [ 486489]   WARN - vdmanager.AvdManagerConnection - Failed to create the SD card.
2017-04-21 02:11:53,860 [ 486489]   WARN - vdmanager.AvdManagerConnection - Failed to create sdcard in the AVD folder.`

After some Googling I found that the problem was that I was using a 64-bit Linux Ubuntu install, which did not have the ia32-libs package installed by default. The mksdcard utility will not run without this package. After installing it, I was able to build the AVD without a problem using the AVD manager. It also appears that the ia32-libs package has been replaced by the following two packages:
- lib32ncurses5
- lib32z1
After installing these packages, I still got the same warning that the AVD could not be created. However, one new warning has been added to the log file `idea.log`, namely:
`2017-04-21 02:19:46,889 [ 959518]   WARN - vdmanager.AvdManagerConnection - /home/wesley/Android/Sdk/emulator/mksdcard: error while loading shared libraries: libgcc_s.so.1: cannot open shared object file: No such file or directory `
`libgcc_s.so` is automatically contained in `gcc-multilib`, so installing `gcc-multilib` in addition to the two aforementioned packages got rid of the error and an AVD could successfully be created.
