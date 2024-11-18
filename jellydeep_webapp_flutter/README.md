# jellydeep_webapp_flutter

## Description

Simple Flutter Web App for API Calls to the Jellydeep Server

## How to solve jdk version 21 issue (New Flutter Project -> Build Error!)

### Error message example

```bash
FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':camera_android_camerax:compileDebugJavaWithJavac'.
> Could not resolve all files for configuration ':camera_android_camerax:androidJdkImage'.
   > Failed to transform core-for-system-modules.jar to match attributes {artifactType=_internal_android_jdk_image, org.gradle.libraryelements=jar, org.gradle.usage=java-runtime}.
      > Execution failed for JdkImageTransform: /Users/jud210/Library/Android/sdk/platforms/android-34/core-for-system-modules.jar.
         > Error while executing process /Applications/Android Studio.app/Contents/jbr/Contents/Home/bin/jlink with arguments {--module-path /Users/jud210/.gradle/caches/transforms-3/d9e926982c2c139ff9125eb7b6be4144/transformed/output/temp/jmod --add-modules java.base --output /Users/jud210/.gradle/caches/transforms-3/d9e926982c2c139ff9125eb7b6be4144/transformed/output/jdkImage --disable-plugin system-modules}

* Try:
> Run with --stacktrace option to get the stack trace.
> Run with --info or --debug option to get more log output.
> Run with --scan to get full insights.
> Get more help at https://help.gradle.org.

BUILD FAILED in 38s
Error: Gradle task assembleDebug failed with exit code 1
```

### jdk version check

```bash
> java --version
openjdk 21.0.2 2024-01-16
OpenJDK Runtime Environment (build 21.0.2+13-58)
OpenJDK 64-Bit Server VM (build 21.0.2+13-58, mixed mode, sharing)
```

### solution

[Solution Link](https://github.com/flutter/flutter/issues/156304#issuecomment-2397707812)

- Basically, you need this in app\build.gradle:

```gradle
android {
  ndkVersion "25.1.8937393"

compileOptions {
  sourceCompatibility JavaVersion.VERSION_17
  targetCompatibility JavaVersion.VERSION_17
}
kotlinOptions {
  jvmTarget = 17
}
```

- This in settings.gradle:

```gradle
id "com.android.application" version "8.3.2" apply false
id "org.jetbrains.kotlin.android" version "2.0.20" apply false
```

- And this in gradle-wrapper.properties:

```properties
distributionUrl=https\://services.gradle.org/distributions/gradle-8.10.2-all.zip
```
