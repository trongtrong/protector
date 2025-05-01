# flutter_protector (0.4.3)
[![pub package](https://img.shields.io/pub/v/flutter_protector)](https://pub.dev/packages/flutter_protector)
[![pub points](https://img.shields.io/pub/points/flutter_protector)](https://pub.dev/packages/flutter_protector/score)
[![likes](https://img.shields.io/pub/likes/flutter_protector)](https://pub.dev/packages/flutter_protector/score)
[![popularity](https://img.shields.io/pub/popularity/flutter_protector)](https://pub.dev/packages/flutter_protector/score)
[![platform](https://img.shields.io/badge/platform-android%20%7C%20ios%20%7C%20web-blue)](https://pub.dev/packages/flutter_protector)

---

## Overview

**flutter_protector** helps secure your Flutter apps by detecting emulator usage, root/jailbreak status, VPN connections, proxy settings, battery optimization status, and potential sniffing apps.  
This plugin is designed to strengthen your app's security layer through device integrity verification and access to system-level settings for additional protection.

---

<div style="display: flex; justify-content: space-between;">
<img src="https://github.com/PuzzleTakX/flutter_protector/blob/master/demo/sc3.jpg?raw=true" alt="image_demo" width="260" height="600">
<img src="https://github.com/PuzzleTakX/flutter_protector/blob/master/demo/screen%20(1).jpg?raw=true" alt="image_demo" width="260" height="600">
<img src="https://github.com/PuzzleTakX/flutter_protector/blob/master/demo/screen%20(2).jpg?raw=true" alt="image_demo" width="260" height="600">
<img src="https://github.com/PuzzleTakX/flutter_protector/blob/master/demo/screen%20(3).jpg?raw=true" alt="image_demo" width="260" height="600">
</div>
<div style="display: flex; justify-content: space-between;">
<img src="https://github.com/PuzzleTakX/flutter_protector/blob/master/demo/screen%20(7).jpg?raw=true" alt="image_demo" width="260" height="600">
<img src="https://github.com/PuzzleTakX/flutter_protector/blob/master/demo/screen%20(6).jpg?raw=true" alt="image_demo" width="260" height="600">
<img src="https://github.com/PuzzleTakX/flutter_protector/blob/master/demo/screen%20(5).jpg?raw=true" alt="image_demo" width="260" height="600">
</div>

## 🚀 Features

- **Platform Version:** Detects platform OS version (Android/iOS).
- **Emulator Detection:** Identifies if the app is running on an emulator (Android), including:
    - `isEmulatorSuper()`
    - `infoEmulatorCheckResult()`
    - `checkTelephonyManager()`
    - `isBlueStacks()`
- **Root/Jailbreak Detection:** Checks if the device is rooted (Android) or jailbroken (iOS).
- **Sniffing App Detection:** Detects known network sniffing apps using `checkForSniffingApps()`.
- **VPN Detection:**
    - Identifies active VPN connections.
    - Detects VPN using network interfaces.
- **Proxy Detection:** Checks if a proxy is set on the device.
- **Local IP Address:** Retrieves the local IP address.
- **Public IP Check:** Determines if the device has a public IP.
- **Developer Options Detection:** Detects if Developer Options are enabled.
- **Phone Info Access:**
    - Retrieve phone number (`phoneNumber()`)
    - Retrieve device ID (`deviceId()`)
    - Get build info (`getBuildInfo()`)
- **Screenshot Security:** Enable or disable screenshot security to prevent screen capture.
- **Battery Optimization:**
    - Check if battery optimization is enabled
    - Request user to disable battery optimization
    - Open battery optimization settings
- **System Settings Access:**
    - Open Developer Options
    - Open Location Settings
    - Open Bluetooth Settings
    - Open Data Usage Settings
    - Open Security Settings
    - Open Accessibility Settings
    - Open Display Settings
    - Open Sound Settings
    - Open VPN Settings
- **Web Support:** Detects the target platform when running on the web.


## Usage

To use this plugin, add `flutter_protector` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_protector: ^0.4.3
```

### Example

Here's a simple example of how to use `flutter_protector` to gather security-related information:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_protector/flutter_protector.dart';

class InfoResult extends StatefulWidget {
  const InfoResult({Key? key}) : super(key: key);

  @override
  State<InfoResult> createState() => _InfoResultState();
}

class _InfoResultState extends State<InfoResult> {
  final flutterProtector = FlutterProtector();
  Map<String, dynamic> result = {};
  bool loading = true;

  @override
  void initState() {
    super.initState();
    initSecurityInfo();
  }

  Future<void> initSecurityInfo() async {
    final pt = await flutterProtector.checkResultSecurityInfo();
    result = pt!;

    result['Platform Version'] = await flutterProtector.getPlatformVersion();
    result['Checked Root Device'] = await flutterProtector.isDeviceRooted();
    result['Checked Emulator Device'] = await flutterProtector.isEmulatorSuper();
    result['Use Proxy Device'] = await flutterProtector.isProxySet();
    result['Is DeveloperOptions Enabled'] = await flutterProtector.isDeveloperOptionsEnabled();
    result['Is VPN Connected'] = await flutterProtector.isVpnConnected();
    result['Is Sniffing Apps'] = await flutterProtector.checkForSniffingApps([]);
    result['Support Camera Flash'] = await flutterProtector.isCameraFlashAvailable();
    result['Support Bluetooth'] = await flutterProtector.isBluetoothAvailable();
    result['Support Camera'] = await flutterProtector.isCameraAvailable();
    result['Has Light Sensor'] = await flutterProtector.isLightSensorAvailable();
    result['Manufacturer'] = await flutterProtector.getManufacturer();
    result['Model'] = await flutterProtector.getModel();
    result['BaseBand'] = await flutterProtector.getBaseBand();
    result['Board'] = await flutterProtector.getBoard();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Info Security Result")),
      body: loading
          ? Center(child: CircularProgressIndicator(strokeWidth: 1.8))
          : ListView(
              padding: EdgeInsets.all(16),
              children: result.keys.map((key) {
                final value = result[key];
                return ListTile(
                  title: Text(key),
                  trailing: value is bool
                      ? Icon(
                          value ? Icons.check_circle : Icons.cancel,
                          color: value ? Colors.green : Colors.red,
                        )
                      : Text(value?.toString() ?? 'N/A'),
                );
              }).toList(),
            ),
    );
  }
}
```
