
# CocoaPods Workarounds for Xcode 27

**Project:** RaptorQALibrary  
**Test Application:** TestPodLibrary  
**Environment:** Xcode 27.0 / CocoaPods 1.17.0  
**Status:** Tested successfully with RaptorQALibrary 1.0.11

## Overview

When integrating RaptorQALibrary through CocoaPods using Xcode 27, two compatibility issues were encountered:

1. CocoaPods could not generate its Pods project because Xcode used `objectVersion = 110`.
2. Xcode's User Script Sandboxing prevented CocoaPods from copying the XCFramework into the application.

The following workarounds allowed the application to build, run, and successfully submit a RaptorQA report.

## 1. Fix the Xcode Object Version

**Error:**

```text
ArgumentError - [Xcodeproj] Unable to find compatibility
version string for object version `110`.
```

### Steps

1. Close Xcode.
2. Open Terminal and navigate to the directory containing `TestPodLibrary.xcodeproj`.
3. Back up the project configuration:

```bash
cp TestPodLibrary.xcodeproj/project.pbxproj \
   TestPodLibrary.xcodeproj/project.pbxproj.backup
```

4. Change the object version from `110` to `60`:

```bash
sed -i '' 's/objectVersion = 110;/objectVersion = 60;/' \
  TestPodLibrary.xcodeproj/project.pbxproj
```

5. Verify the change:

```bash
grep -n -E 'objectVersion|preferredProjectObjectVersion' \
  TestPodLibrary.xcodeproj/project.pbxproj
```

Expected:

```text
objectVersion = 60;
preferredProjectObjectVersion = 60;
```

6. Reinstall the pods:

```bash
pod install
```

7. Open the generated `.xcworkspace` file rather than the `.xcodeproj` file.

**Important:** This is a temporary compatibility workaround, not an official Xcode project conversion. Xcode 27 may restore the newer object version, and newer project features may not be fully compatible with older formats. Use cautiously and retain the backup.

## 2. Disable User Script Sandboxing

**Error:**

```text
Sandbox: rsync deny(1) file-read-data
Sandbox: rsync deny(1) file-write-create
Operation not permitted
```

These errors occurred when CocoaPods attempted to embed `RaptorQALibrary.framework` into the application.

### Steps

1. Open `TestPodLibrary.xcworkspace` in Xcode.
2. Select the **TestPodLibrary** project in the Project Navigator.
3. Under **TARGETS**, select **TestPodLibrary**.
4. Open **Build Settings**.
5. Search for `User Script Sandboxing`.
6. Set **User Script Sandboxing** to **No**.

Equivalent build setting:

```text
ENABLE_USER_SCRIPT_SANDBOXING = NO
```

7. Select **Product → Clean Build Folder** (`Shift + Command + K`).
8. Select **Product → Build** (`Command + B`).

**Important:** Disabling script sandboxing relaxes build-script restrictions. Only use this workaround with trusted dependencies and build scripts.

## 3. Verify the Installation

After applying both workarounds:

- `pod install` completed successfully.
- RaptorQALibrary 1.0.11 appeared in the Pods project.
- The application compiled and launched.
- The RaptorQA SDK successfully submitted a report to the hosted backend.

**Result:** CocoaPods integration verified with Xcode 27.0.

## Future Maintenance

These workarounds should be revisited when CocoaPods and its `xcodeproj` dependency officially support the Xcode 27 project format.

The fixes were validated in the TestPodLibrary application and should not automatically be applied to customer projects without checking their project structure and build configuration.
