# flutter_protector (0.3.5)

A Flutter plugin that provides device and platform-related security features.

[![pub package](https://img.shields.io/pub/v/flutter_protector)](https://pub.dev/packages/flutter_protector)

---

## Overview

**flutter_protector** helps secure your Flutter apps by detecting emulator usage, root/jailbreak status, VPN connections, proxy settings, and potential sniffing apps.  
This plugin is designed to strengthen your app's security layer through device integrity verification.

> ⚠️ **Important:** While this plugin adds security checks, no single method can guarantee 100% protection. Always combine it with best practices such as code obfuscation, encrypted storage, and server-side validation.

---

## 🚀 Features

- **Platform Version:** Detects platform OS version (Android/iOS).
- **Emulator Detection:** Identifies if the app is running on an emulator (Android).
- **Root/Jailbreak Detection:** Checks if the device is rooted (Android) or jailbroken (iOS).
- **Sniffing App Detection:** Detects known network sniffing apps.
- **VPN Detection:** Identifies active VPN connections.
- **Proxy Detection:** Checks if a proxy is set on the device.
- **Local IP Address:** Retrieves the local IP address.
- **Public IP Check:** Determines if the device has a public IP.
- **VPN Interface Check:** Detects VPNs using network interfaces.
- **Target Platform Detection on Web:** Detects the target platform when running on web.

---

## 📦 Getting Started

1. **Add Dependency:**

    ```yaml
    dependencies:
      flutter_protector: ^latest_version # Replace with the latest version from pub.dev
    ```

2. **Install Packages:**

    ```bash
    flutter pub get
    ```

3. **Import Package:**

    ```dart
    import 'package:flutter_protector/flutter_protector.dart';
    ```

---

## 📜 Changelog

### [0.3.5] - 2025-02-19
- Improved emulator detection.
- Added security detail result checks.
- Fixed issues on Samsung devices (A21, A10, A31, A52, A51).
- Updated native C++ library.
- Released the new package version.

### [0.3.1] - 2025-02-19
- Released package update.
- Enhanced emulator checks.
- Added `checkTelephonyManager` and `isBlueStacks` methods.

### [0.1.2] - 2025-01-20
- Released package update.
- Improved example and test files.
- Verified functionality on Samsung, Xiaomi, Huawei, Realme, Motorola devices.

### [0.1.2] - 2025-01-18
- Released package update.
- Disabled app screenshots for better security.

### [0.1.2] - 2025-01-15
- Added `isEmulatorSuper` support for Android 6 to Android 15.

### [0.1.0] - 2025-01-12
- Updated OS build data retrieval.
- Added device ID fetching for build info.
- Implemented IMEI and enhanced emulator detection.
- Updated README documentation.

### [0.0.6] - 2025-01-12
- Updated build data OS functionality.
- Fixed emulator detection bugs.

### [0.0.5] - 2025-01-12
- Minor bug fixes and performance improvements.
- Removed web platform support.

### [0.0.3] - 2025-01-12
- Minor bug fixes and optimizations.

### [0.0.2+2] - 2025-01-12
- Added:
    - Emulator detection
    - Root/Jailbreak detection
    - VPN/Proxy detection
    - Sniffing apps detection
    - Public and local IP check
- Minor bug fixes.

### [0.0.2] - 2025-01-01
- Initial release of the flutter_protector plugin with basic security features.

