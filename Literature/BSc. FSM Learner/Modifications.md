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
    if(Runtime.getRuntime().exec("adb shell uiautomator dump").waitFor() >= 0)
      return Runtime.getRuntime().exec("adb pull /sdcard/window_dump.xml alphabet/window_dumps/" + fileName).waitFor();
  } catch (IOException e) {
  ...
}
```
