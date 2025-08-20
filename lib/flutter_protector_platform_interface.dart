import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_protector_method_channel.dart';

abstract class FlutterProtectorPlatform extends PlatformInterface {
  /// Constructs a FlutterProtectorPlatform.
  FlutterProtectorPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterProtectorPlatform _instance = MethodChannelFlutterProtector();

  /// The default instance of [FlutterProtectorPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterProtector].
  static FlutterProtectorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterProtectorPlatform] when
  /// they register themselves.
  static set instance(FlutterProtectorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
  //
  // Future<bool?> isEmulatorOld() async {
  //   // TODO: Implement logic to detect if the device is an emulator.
  //   throw UnimplementedError('Emulator detection has not been implemented.');
  // }

  Future<bool?> isDeviceRooted() async {
    // TODO: Implement logic to detect if the device is an emulator.
    throw UnimplementedError('Emulator detection has not been implemented.');
  }
  Future<bool?> isDebugAttach() async {
    throw UnimplementedError('DebugAttach UnimplementedError');
  }
  Future<bool?> isDeveloperOptionsEnabled() async {
    // TODO: Implement logic to detect if the device is an emulator.
    throw UnimplementedError('Emulator detection has not been implemented.');

  }
  Future<bool?> checkTelephonyManager() async {
    // TODO: Implement logic to detect if the device is an emulator.
    throw UnimplementedError('Emulator detection has not been implemented.');

  }
  Future<bool?> isBlueStacks() async {
    // TODO: Implement logic to detect if the device is an emulator.
    throw UnimplementedError('Emulator detection has not been implemented.');

  }
  Future<Map<String, dynamic>?> checkResultSecurityInfo() async {
    // TODO: Implement logic to detect if the device is an emulator.
    throw UnimplementedError('Emulator detection has not been implemented.');

  }
  Future<String?> infoEmulatorCheckResult() async {
    // TODO: Implement logic to detect if the device is an emulator.
    throw UnimplementedError('Emulator detection has not been implemented.');

  }
  Future<int?> checkResultSecurity() async {
    // TODO: Implement logic to detect if the device is an emulator.
    throw UnimplementedError('Emulator detection has not been implemented.');

  }

  Future<Map<String,dynamic>?> checkEmu() async {
    // TODO: Implement logic to detect if the device is an emulator.
    throw UnimplementedError('Emulator detection has not been implemented.');
  }

  Future<bool?> checkForSniffingApps(List<String> sniffingAppsToCheck ) async {
    // TODO: Implement logic to detect if the device is an emulator.
    throw UnimplementedError('Emulator detection has not been implemented.');
  }
  Future<bool?> screenshotSecurity(bool enable ) async {
    // TODO: Implement logic to detect if the device is an emulator.
    throw UnimplementedError('Emulator detection has not been implemented.');
  }
  Future<void> openDeveloperOption() {
    throw UnimplementedError('openDeveloperOption() has not been implemented.');
  }

  Future<void> openLocationSettings() {
    throw UnimplementedError('openLocationSettings() has not been implemented.');
  }

  Future<void> openBluetoothSettings() {
    throw UnimplementedError('openBluetoothSettings() has not been implemented.');
  }

  Future<void> openDataUsageSettings() {
    throw UnimplementedError('openDataUsageSettings() has not been implemented.');
  }

  Future<void> openSecuritySettings() {
    throw UnimplementedError('openSecuritySettings() has not been implemented.');
  }

  Future<void> openAccessibilitySettings() {
    throw UnimplementedError('openAccessibilitySettings() has not been implemented.');
  }

  Future<void> openDisplaySettings() {
    throw UnimplementedError('openDisplaySettings() has not been implemented.');
  }

  Future<void> openSoundSettings() {
    throw UnimplementedError('openSoundSettings() has not been implemented.');
  }

  Future<void> openVpnSettings() {
    throw UnimplementedError('openVpnSettings() has not been implemented.');
  }

  Future<void> openBatteryOptimizationSettings() {
    throw UnimplementedError('openBatteryOptimizationSettings() has not been implemented.');
  }

  Future<bool?> isBatteryOptimizationEnabled() {
    throw UnimplementedError('isBatteryOptimizationEnabled() has not been implemented.');
  }
  Future<List<dynamic>?> emulatorDetails() async {
    throw UnimplementedError('emulatorDetails() has not been implemented.');
  }

  Future<void> requestDisableBatteryOptimization() {
    throw UnimplementedError('requestDisableBatteryOptimization() has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    // TODO: Implement logic to fetch platform version.
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> phoneNumber() {
    // TODO: Implement logic to fetch platform version.
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<Map<String,dynamic>?> getBuildInfo() async {
    // TODO: Implement logic to fetch platform version.
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> deviceId() {
    // TODO: Implement logic to fetch platform version.
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> imei() {
    // TODO: Implement logic to fetch platform version.
    throw UnimplementedError('platformVersion() has not been implemented.');
  }


  Future<bool?> isVpnConnected() async {
    // TODO: Implement logic to detect if the device is connected to a VPN.
    throw UnimplementedError('VPN detection has not been implemented.');
  }


  Future<bool?> isProxySet() async {
    // TODO: Implement logic to detect if a proxy is set.
    throw UnimplementedError('Proxy detection has not been implemented.');
  }

  Future<String?> getLocalIpAddress() async {
    // TODO: Implement logic to fetch the local IP address.
    throw UnimplementedError('Local IP address retrieval has not been implemented.');
  }


  Future<bool?> isPublicIP() async {
    // TODO: Implement logic to detect if the device has a public IP.
    throw UnimplementedError('Public IP check has not been implemented.');
  }


  Future<bool?> isVpnUsingNetworkInterface() async {
    // TODO: Implement logic to detect if the network interface is using a VPN.
    throw UnimplementedError('VPN network interface detection has not been implemented.');
  }

}
