import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_protector_platform_interface.dart';

/// An implementation of [FlutterProtectorPlatform] that uses method channels.
class MethodChannelFlutterProtector extends FlutterProtectorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_protector');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
  @override
  Future<bool?> isEmulator() async {
    final isEmulator = await methodChannel.invokeMethod<bool>('isEmulator');
    return isEmulator;
  }
}
