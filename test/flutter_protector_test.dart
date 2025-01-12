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
