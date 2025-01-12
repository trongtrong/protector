// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web;

import 'flutter_protector_platform_interface.dart';

/// A web implementation of the FlutterProtectorPlatform of the FlutterProtector plugin.
class FlutterProtectorWeb extends FlutterProtectorPlatform {
  /// Constructs a FlutterProtectorWeb
  FlutterProtectorWeb();

  static void registerWith(Registrar registrar) {
    FlutterProtectorPlatform.instance = FlutterProtectorWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = web.window.navigator.userAgent;
    return version;
  }

  @override
  /// Checks if the current device is running on an emulator.
  /// Returns `true` if the device is an emulator, otherwise `false`.
  Future<bool?> isEmulator() async {
    // TODO: Implement logic to detect if the device is an emulator.
    throw UnimplementedError('Emulator detection has not been implemented.');
  }

  @override
  /// Determines if the device is connected to a VPN.
  /// Returns `true` if a VPN connection is detected, otherwise `false`.
  Future<bool?> isVpnConnected() async {
    // TODO: Implement logic to detect if the device is connected to a VPN.
    throw UnimplementedError('VPN detection has not been implemented.');
  }

  @override
  /// Checks if a proxy is set on the device.
  /// Returns `true` if a proxy configuration is detected, otherwise `false`.
  Future<bool?> isProxySet() async {
    // TODO: Implement logic to detect if a proxy is set.
    throw UnimplementedError('Proxy detection has not been implemented.');
  }

  @override
  /// Retrieves the local IP address of the device.
  /// Returns the local IP address as a string.
  Future<String?> getLocalIpAddress() async {
    // TODO: Implement logic to fetch the local IP address.
    throw UnimplementedError('Local IP address retrieval has not been implemented.');
  }

  @override
  /// Checks if the device is using a public IP address.
  /// Returns `true` if the IP is public, otherwise `false`.
  Future<bool?> isPublicIP() async {
    // TODO: Implement logic to detect if the device has a public IP.
    throw UnimplementedError('Public IP check has not been implemented.');
  }
  @override
  /// Checks if the device is using a public IP address.
  /// Returns `true` if the IP is public, otherwise `false`.
  Future<bool?> isDeviceRooted() async {
    // TODO: Implement logic to detect if the device has a public IP.
    throw UnimplementedError('Public IP check has not been implemented.');
  }
  @override
  Future<bool?> checkForSniffingApps(List<String> sniffingAppsToCheck) async {
    // TODO: Implement logic to detect if the device has a public IP.
    throw UnimplementedError('Public IP check has not been implemented.');
  }

  @override
  /// Determines if a VPN is being used by analyzing the network interface.
  /// Returns `true` if a VPN is detected, otherwise `false`.
  Future<bool?> isVpnUsingNetworkInterface() async {
    // TODO: Implement logic to detect if the network interface is using a VPN.
    throw UnimplementedError('VPN network interface detection has not been implemented.');
  }


}
