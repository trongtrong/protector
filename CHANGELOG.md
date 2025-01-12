# flutter_protector (0.0.2)

A Flutter plugin that provides device and platform-related security features.

[![pub package](https://img.shields.io/pub/v/flutter_protector)](https://pub.dev/packages/flutter_protector)

This plugin offers various methods to enhance the security of your Flutter applications by providing information about the device and platform. It includes checks for emulator detection, root/jailbreak status, sniffing apps, VPN connection status, proxy settings, and more.

**Important Note:** While this plugin provides helpful checks, it's crucial to understand that no single method can guarantee complete security. Use these checks as part of a comprehensive security strategy that includes other best practices like code obfuscation, secure data storage, and server-side validation.

## [0.0.4] - 2025-01-12

### Fixed
- Minor bug fixes and performance improvements.
- remove web platform

## [0.0.3] - 2025-01-12

### Fixed
- Minor bug fixes and performance improvements.

## [0.0.2+2] - 2025-01-12
### Added
- Added features for platform and device security checks, including:
    - Emulator detection
    - Root/Jailbreak detection
    - VPN and Proxy detection
    - Sniffing app detection
    - Public and local IP address checks

### Fixed
- Minor bug fixes and performance improvements.

## [0.0.2] - 2025-01-01
### Added
- Initial release of the flutter_protector plugin with basic security features.




## Features

*   **Platform Version:** Retrieves the platform version (e.g., Android 13, iOS 16).
*   **Emulator Detection:** Checks if the app is running on an emulator (Android).
*   **Root/Jailbreak Detection:** Checks if the device is rooted (Android) or jailbroken (iOS).
*   **Sniffing App Detection:** Checks for the presence of known sniffing apps.
*   **VPN Connection Detection:** Checks if a VPN is currently connected.
*   **Proxy Detection:** Checks if a proxy is set on the device.
*   **Local IP Address:** Retrieves the local IP address of the device.
*   **Public IP Check:** Checks if the device's IP address is a public IP.
*   **VPN Using Network Interface Check:** Checks if the VPN is using a network interface (if a VPN is connected).
*   **Target Platform Web Launch Mode:** Detects target platform when running on the web.

## Getting Started

1.  **Add Dependency:**

    ```yaml
    dependencies:
      flutter_protector: ^latest_version # Replace with the latest version from pub.dev
    ```

2.  **Install Packages:**

    ```bash
    flutter pub get
    ```

3.  **Import:**

    ```dart
    import 'package:flutter_protector/flutter_protector.dart';
    ```

