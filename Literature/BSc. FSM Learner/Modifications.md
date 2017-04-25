# Modifications

Fix and Create new `make_dump.sh` file with the following contents:

```shell
args=($@)
FILENAME=${args[0]}
adb shell uiautomator dump
echo ${FILENAME}
adb pull /sdcard/window_dump.xml alphabet/window_dumps/$FILENAME  
```

Download the source code from [here](https://github.com/bunqcom/fsm-learner). Upon compilation, two classes don't compile any more. The classes `AndroidInstrumentator.java` and `IOSInstrumentator.java`.  Both classes do not compile because they contain statements like:
```java
waitFor.until(ExpectedConditions.elementToBeClickable(By.xpath(xpath)));
```
These can be changed to the following code, because of **reason**:

```java
waitForLogin.until((Function<? super WebDriver, ?>) ExpectedConditions.elementToBeClickable(By.id("com.myApp.android:id/myBtn")));
```

Generate class files with `mvn compile` instead of `mvn install` to omit tests.

Modify the source code: Main.java contains the following method:
```java
private int runAlphabetScript(String fileName) {
  ...
  try {
    alphabetScript = Runtime.getRuntime().exec("scripts/make_dump.sh " + fileName);
    return alphabetScript.waitFor();
  } catch (IOException e) {
  ...
}
```

Modify the specified method to:
```java
private int runAlphabetScript(String fileName) {
  ...
  try {
    if(Runtime.getRuntime().exec("adb shell uiautomator dump").waitFor() != 0)
      return Runtime.getRuntime().exec("adb pull /sdcard/window_dump.xml alphabet/window_dumps/" + fileName).waitFor();
  } catch (IOException e) {
  ...
}
```

## Learning
When performing the learn action with the following command: `mvn exec:java -Dexec.mainClass="com.bunq.main.Main" -Dexec.args="learn"`, the following stack trace is generated:
```java
java.lang.reflect.InvocationTargetException
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at com.bunq.main.Main.execute(Main.java:244)
	at com.bunq.main.Main.main(Main.java:315)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.codehaus.mojo.exec.ExecJavaMojo$1.run(ExecJavaMojo.java:282)
	at java.lang.Thread.run(Thread.java:745)
Caused by: java.lang.NoSuchMethodError: com.google.common.collect.ImmutableSet.toImmutableSet()Ljava/util/stream/Collector;
	at org.openqa.selenium.remote.ProtocolHandshake.streamW3CProtocolParameters(ProtocolHandshake.java:238)
	at org.openqa.selenium.remote.ProtocolHandshake.createSession(ProtocolHandshake.java:104)
	at org.openqa.selenium.remote.HttpCommandExecutor.execute(HttpCommandExecutor.java:141)
	at org.openqa.selenium.remote.RemoteWebDriver.execute(RemoteWebDriver.java:604)
	at io.appium.java_client.AppiumDriver.execute(AppiumDriver.java:180)
	at org.openqa.selenium.remote.RemoteWebDriver.startSession(RemoteWebDriver.java:244)
	at org.openqa.selenium.remote.RemoteWebDriver.<init>(RemoteWebDriver.java:131)
	at org.openqa.selenium.remote.RemoteWebDriver.<init>(RemoteWebDriver.java:158)
	at io.appium.java_client.AppiumDriver.<init>(AppiumDriver.java:109)
	at io.appium.java_client.android.AndroidDriver.<init>(AndroidDriver.java:39)
	at com.bunq.teacher.AndroidInstrumentator.startApp(AndroidInstrumentator.java:48)
	at com.bunq.teacher.FsmTeacher.start(FsmTeacher.java:36)
	at com.bunq.learner.SulAdapter.<init>(SulAdapter.java:51)
	at com.bunq.learner.FsmLearner.instantiateSuls(FsmLearner.java:162)
	at com.bunq.learner.FsmLearner.setUpLearner(FsmLearner.java:205)
	at com.bunq.main.Main.learn(Main.java:81)
	... 12 more
	Suppressed: java.io.IOException: Incomplete document
		at com.google.gson.stream.JsonWriter.close(JsonWriter.java:527)
		at org.openqa.selenium.remote.ProtocolHandshake.createSession(ProtocolHandshake.java:121)
		... 26 more
```

It appears that the class `AndroidInstrumentator` with method `startApp` causes the runtime error. The `AndroidInstrumentator` class takes care of all actions that can be executed on an Android device and depends heavily on Appium. Debugging the code, shows that the following statement within the `AndroidInstrumentator` class is responsible for the failure:
```java
driver = new AndroidDriver(new URL("http://127.0.0.1:4723/wd/hub"), capabilities);
```

Update Guave to 21.0 (https://github.com/google/error-prone/issues/528). Done by editing `pom.xml` with https://mvnrepository.com/artifact/com.google.guava/guava/21.0.

With updated Guava, another exception is thrown:
```java
Exception in AndroidInstrumentator:startApp
org.openqa.selenium.SessionNotCreatedException: Unable to create new remote session. desired capabilities = Capabilities [{appPackage=com.bunq.android, appActivity=com.bunq.android.ui.activity.MainActivity, noReset=false, newCommandTimeout=100, platformVersion=6.0.1, platformName=Android, deviceName=OnePlus X}], required capabilities = Capabilities [{}]
Build info: version: '3.3.1', revision: '5234b325d5', time: '2017-03-10 09:10:29 +0000'
System info: host: 'ubuntu', ip: '127.0.1.1', os.name: 'Linux', os.arch: 'amd64', os.version: '4.8.0-46-generic', java.version: '1.8.0_121'
Driver info: driver.version: AndroidDriver
	at org.openqa.selenium.remote.ProtocolHandshake.createSession(ProtocolHandshake.java:126)
	at org.openqa.selenium.remote.HttpCommandExecutor.execute(HttpCommandExecutor.java:141)
	at org.openqa.selenium.remote.RemoteWebDriver.execute(RemoteWebDriver.java:604)
	at io.appium.java_client.AppiumDriver.execute(AppiumDriver.java:180)
	at org.openqa.selenium.remote.RemoteWebDriver.startSession(RemoteWebDriver.java:244)
	at org.openqa.selenium.remote.RemoteWebDriver.<init>(RemoteWebDriver.java:131)
	at org.openqa.selenium.remote.RemoteWebDriver.<init>(RemoteWebDriver.java:158)
	at io.appium.java_client.AppiumDriver.<init>(AppiumDriver.java:109)
	at io.appium.java_client.android.AndroidDriver.<init>(AndroidDriver.java:39)
	at com.bunq.teacher.AndroidInstrumentator.startApp(AndroidInstrumentator.java:50)
	at com.bunq.teacher.FsmTeacher.start(FsmTeacher.java:36)
	at com.bunq.learner.SulAdapter.<init>(SulAdapter.java:51)
	at com.bunq.learner.FsmLearner.instantiateSuls(FsmLearner.java:162)
	at com.bunq.learner.FsmLearner.setUpLearner(FsmLearner.java:205)
	at com.bunq.main.Main.learn(Main.java:81)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at com.bunq.main.Main.execute(Main.java:244)
	at com.bunq.main.Main.main(Main.java:315)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.codehaus.mojo.exec.ExecJavaMojo$1.run(ExecJavaMojo.java:282)
	at java.lang.Thread.run(Thread.java:745)
```
After an insane amount of Googling and discussing the stack trace with other people, one can derive that Selenium cannot send HTTP requests to the AndroidDriver because the ProtocolHandshake continuously fails. This is due to the fact that Guava 21.0 (which has just been set) and Appium's java-client 2.1.0 are incompatible in terms of HTTP session establishment, which was the root cause for the failing ProtocolHandshake. Updating Appium's dependency configuration to the latest version: 5.0.0-BETA7, overcame the problem. No stable Appium version (latest stable is Appium 4.1.2) was able to make a successful handshake.
