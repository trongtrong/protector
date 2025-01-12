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


  Future<bool?> isEmulator() async {
    throw UnimplementedError('not found emulator');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
