# flutter_protector (0.2.3)

A Flutter plugin that provides device and platform-related security features.

[![pub package](https://img.shields.io/pub/v/flutter_protector.svg)](https://pub.dev/packages/flutter_protector)
[![pub points](https://img.shields.io/pub/points/flutter_protector?color=2E8B57&label=pub%20points)](https://pub.dev/packages/flutter_protector/score)



This plugin offers various methods to enhance the security of your Flutter applications by providing information about the device and platform. It includes checks for emulator detection, root/jailbreak status, sniffing apps, VPN connection status, proxy settings, and more.

**Important Note:** While this plugin provides helpful checks, it's crucial to understand that no single method can guarantee complete security. Use these checks as part of a comprehensive security strategy that includes other best practices like code obfuscation, secure data storage, and server-side validation.

**Demo:**

<img src="https://github.com/PuzzleTakX/flutter_protector/blob/master/demo/device.jpg?raw=true" alt="image_demo" width="307" height="335">


<img src="https://github.com/PuzzleTakX/flutter_protector/blob/master/demo/image.png?raw=true" alt="image_demo" width="260" height="600">



## Features

*   **Platform Version:** Retrieves the platform version (e.g., Android 13).
*   **Emulator Detection:** Checks if the app is running on an emulator (Android).
*   **Root/Jailbreak Detection:** Checks if the device is rooted (Android).
*   **Sniffing App Detection:** Checks for the presence of known sniffing apps.
*   **VPN Connection Detection:** Checks if a VPN is currently connected.
*   **Proxy Detection:** Checks if a proxy is set on the device.
*   **Local IP Address:** Retrieves the local IP address of the device.
*   **Public IP Check:** Checks if the device's IP address is a public IP.
*   **VPN Using Network Interface Check:** Checks if the VPN is using a network interface (if a VPN is connected).
*   **Target Platform Web Launch Mode:** Detects target platform when running on the web.
*   **IMEI:** Get the device's IMEI (imei).
*   **Phone Number:** Get the device's phone number (phoneNumber).
*   **Device ID:** Retrieve the device ID (deviceId).



## Getting Started


## Android Permission  use get imei , phone number and deviceId , check vpn proxy and sniffing


    ```bash
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.READ_PRIVILEGED_PHONE_STATE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.READ_PHONE_NUMBERS" />
    <uses-permission android:name="android.permission.READ_PRIVILEGED_PHONE_STATE"
        tools:ignore="ProtectedPermissions" />
    ```

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

