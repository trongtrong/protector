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

  @override
  Future<bool?> isEmulator() {
    throw UnimplementedError();
  }

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
  Future<bool?> isEmulatorSuper() {
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
