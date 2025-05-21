import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_protector/flutter_protector.dart';
import 'package:flutter_protector/flutter_protector_platform_interface.dart';
import 'package:flutter_protector/flutter_protector_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterProtectorPlatform
    with MockPlatformInterfaceMixin
    implements FlutterProtectorPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  // @override
  // Future<bool?> isEmulatorOld() {
  //   throw UnimplementedError();
  // }

  @override
  Future<String?> getLocalIpAddress() {
    throw UnimplementedError();
  }
  @override
  Future<bool?> checkForSniffingApps(List<String> sniffingAppsToCheck) {
    throw UnimplementedError();
  }

  @override
  Future<bool?> isProxySet() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> isPublicIP() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> isVpnConnected() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> isVpnUsingNetworkInterface() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> isDeviceRooted() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> isDeveloperOptionsEnabled() {
    throw UnimplementedError();
  }

  @override
  Future<String?> deviceId() {
    throw UnimplementedError();
  }

  @override
  Future<String?> imei() {
    throw UnimplementedError();
  }

  @override
  Future<String?> phoneNumber() {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?> getBuildInfo() {
    throw UnimplementedError();
  }

  @override
  Future<String?> isEmulatorSuper() {
    throw UnimplementedError();
  }

  @override
  Future<Map<String,dynamic>?> checkEmu() {
    throw UnimplementedError();
  }

  @override
  Future<int?> checkResultSecurity() {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?> checkResultSecurityInfo() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> screenshotSecurity(bool enable) {
    throw UnimplementedError();
  }

  @override
  Future<bool?> checkTelephonyManager() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> isBlueStacks() {
    throw UnimplementedError();
  }

  @override
  Future<String?> infoEmulatorCheckResult() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> isBatteryOptimizationEnabled() {
    throw UnimplementedError();
  }

  @override
  Future<void> openAccessibilitySettings() {
    throw UnimplementedError();
  }

  @override
  Future<void> openBatteryOptimizationSettings() {
    throw UnimplementedError();
  }

  @override
  Future<void> openBluetoothSettings() {
    throw UnimplementedError();
  }

  @override
  Future<void> openDataUsageSettings() {
    throw UnimplementedError();
  }

  @override
  Future<void> openDeveloperOption() {
    throw UnimplementedError();
  }

  @override
  Future<void> openDisplaySettings() {
    throw UnimplementedError();
  }

  @override
  Future<void> openLocationSettings() {
    throw UnimplementedError();
  }

  @override
  Future<void> openSecuritySettings() {
    throw UnimplementedError();
  }

  @override
  Future<void> openSoundSettings() {
    throw UnimplementedError();
  }

  @override
  Future<void> openVpnSettings() {
    throw UnimplementedError();
  }

  @override
  Future<void> requestDisableBatteryOptimization() {
    throw UnimplementedError();
  }

  @override
  Future<List?> emulatorDetails() {
    throw UnimplementedError();
  }
}

void main() {
  final FlutterProtectorPlatform initialPlatform = FlutterProtectorPlatform.instance;

  test('$MethodChannelFlutterProtector is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterProtector>());
  });

  test('getPlatformVersion', () async {
    FlutterProtector flutterProtectorPlugin = FlutterProtector();
    MockFlutterProtectorPlatform fakePlatform = MockFlutterProtectorPlatform();
    FlutterProtectorPlatform.instance = fakePlatform;

    expect(await flutterProtectorPlugin.getPlatformVersion(), '42');
  });
}
