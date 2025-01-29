// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter_protector/target_platform_protector.dart';

import 'flutter_protector_platform_interface.dart';

/// This class provides access to various device and platform-related security features.
class FlutterProtector {
  /// Retrieves the platform version (e.g., Android 13, iOS 16).
  /// This method delegates the call to the platform-specific implementation.
  Future<String?> getPlatformVersion() async {
    return FlutterProtectorPlatform.instance.getPlatformVersion();
  }

  // /// Gets the target platform for web launch mode.
  // /// This method uses `DeviceInfoPlugin` to get web browser information and attempts to
  // /// map it to a corresponding `TargetPlatformProtector` enum value based on the platform string.
  // ///
  // /// **Note:** This approach might not be entirely reliable for web launch mode detection,
  // /// and a more robust solution might be needed depending on your specific requirements.
  // Future<TargetPlatformProtector> get targetPlatformWebLaunchMode async {
  //   final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  //   final webLaunch = await deviceInfoPlugin.webBrowserInfo;
  //
  //   switch (webLaunch.platform) {
  //     case "Win32":
  //       return TargetPlatformProtector.linux;
  //     case "MacIntel":
  //       return TargetPlatformProtector.macOS;
  //     case "Linux aarch64":
  //     case "arm":
  //       return TargetPlatformProtector.android;
  //     case "iPhone":
  //       return TargetPlatformProtector.ios;
  //     default:
  //       return TargetPlatformProtector.unknown;
  //   }
  // }


  /// Checks if the device is running on an emulator.
  /// This method delegates the call to the platform-specific implementation.
  Future<bool?> isEmulatorSuper() async {
    return FlutterProtectorPlatform.instance.isEmulatorSuper();
  }

  /// Checks if the device is rooted (Android) or jailbroken (iOS).
  /// This method delegates the call to the platform-specific implementation.
  Future<bool?> isDeviceRooted() async {
    return FlutterProtectorPlatform.instance.isDeviceRooted();
  }

  /// Checks for the presence of known sniffing apps installed on the device.
  /// This method takes a list of package names (Android) or bundle identifiers (iOS) of sniffing apps to check for.
  /// It delegates the call to the platform-specific implementation.
  Future<bool?> checkForSniffingApps(List<String> sniffingAppsToCheck) async {
    return FlutterProtectorPlatform.instance.checkForSniffingApps(sniffingAppsToCheck);
  }
  /// check screen shot in app AND RECORDING
  Future<bool?> screenshotSecurity(bool enable) async {
    return FlutterProtectorPlatform.instance.screenshotSecurity(enable);
  }

  /// Checks if a VPN is currently connected on the device.
  /// This method delegates the call to the platform-specific implementation.
  Future<bool?> isVpnConnected() async {
    return FlutterProtectorPlatform.instance.isVpnConnected();
  }

  /// Checks if a enable developer option in android
  Future<bool?> isDeveloperOptionsEnabled() async {
    return FlutterProtectorPlatform.instance.isDeveloperOptionsEnabled();
  }

  Future<Map<String, dynamic>?> checkResultSecurityInfo() async {
    return FlutterProtectorPlatform.instance.checkResultSecurityInfo();
  }
  Future<int?> checkResultSecurity() async {
    return FlutterProtectorPlatform.instance.checkResultSecurity();
  }

  /// Checks if a proxy is currently set on the device.
  /// This method delegates the call to the platform-specific implementation.
  Future<bool?> isProxySet() async {
    return FlutterProtectorPlatform.instance.isProxySet();
  }

  /// Retrieves the local IP address of the device.
  /// This method delegates the call to the platform-specific implementation.
  Future<String?> getLocalIpAddress() async {
    return FlutterProtectorPlatform.instance.getLocalIpAddress();
  }

  Future<String?> phoneNumber() async {
    return FlutterProtectorPlatform.instance.phoneNumber();
  }

  Future<String?> deviceId() async {
    return FlutterProtectorPlatform.instance.deviceId();
  }


  Future<Map<String, dynamic>?> getBuildInfo() async {
    return FlutterProtectorPlatform.instance.getBuildInfo();
  }

  Future<String?> imei() async {
    return FlutterProtectorPlatform.instance.imei();
  }

  /// Checks if the device's IP address is a public IP.
  /// This method delegates the call to the platform-specific implementation.
  Future<bool?> isPublicIP() async {
    return FlutterProtectorPlatform.instance.isPublicIP();
  }

  /// Checks if the VPN is using a network interface (if a VPN is connected).
  /// This method delegates the call to the platform-specific implementation.
  Future<bool?> isVpnUsingNetworkInterface() async {
    return FlutterProtectorPlatform.instance.isVpnUsingNetworkInterface();
  }
}