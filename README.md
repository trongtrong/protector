# flutter\_protector (0.2.8)

A Flutter plugin that provides device and platform-related security features.

&#x20;

This plugin offers various methods to enhance the security of your Flutter applications by providing information about the device and platform. It includes checks for emulator detection, root/jailbreak status, sniffing apps, VPN connection status, proxy settings, and more.

**Important Note:** While this plugin provides helpful checks, it's crucial to understand that no single method can guarantee complete security. Use these checks as part of a comprehensive security strategy that includes other best practices like code obfuscation, secure data storage, and server-side validation.

**Demo:**

## Features

- **Platform Version:** Retrieves the platform version (e.g., Android 13).
- **Emulator Detection:** Checks if the app is running on an emulator (Android).
- **Root/Jailbreak Detection:** Checks if the device is rooted (Android).
- **Sniffing App Detection:** Checks for the presence of known sniffing apps.
- **VPN Connection Detection:** Checks if a VPN is currently connected.
- **Proxy Detection:** Checks if a proxy is set on the device.
- **Local IP Address:** Retrieves the local IP address of the device.
- **Public IP Check:** Checks if the device's IP address is a public IP.
- **VPN Using Network Interface Check:** Checks if the VPN is using a network interface (if a VPN is connected).
- **Target Platform Web Launch Mode:** Detects target platform when running on the web.
- **IMEI:** Get the device's IMEI (imei).
- **Phone Number:** Get the device's phone number (phoneNumber).
- **Device ID:** Retrieve the device ID (deviceId).
- **Support Camera Flash:** Checks if the device supports a camera flash.
- **Support Bluetooth:** Checks if the device supports Bluetooth.
- **Support Camera:** Checks if the device has camera support.
- **Has Light Sensor:** Checks if the device has a light sensor.
- **Manufacturer:** Retrieves the device manufacturer.
- **Model:** Retrieves the device model.
- **BaseBand:** Retrieves the baseband version of the device.
- **Board:** Retrieves the device's board information.


## Usage

To use this plugin, add `flutter_protector` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_protector: ^0.2.8
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

