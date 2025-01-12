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
  @override
  Future<bool?> isDeviceRooted() async {
    final isEmulator = await methodChannel.invokeMethod<bool>('isDeviceRooted');
    return isEmulator;
  }
  @override
  Future<bool?> checkForSniffingApps(List<String> sniffingAppsToCheck ) async {
    final isEmulator = await methodChannel.invokeMethod<bool>('checkForSniffingApps',sniffingAppsToCheck);
    return isEmulator;
  }

  @override
  Future<bool?> isVpnConnected() async {
    final isVpnConnected = await methodChannel.invokeMethod<bool>('isVpnConnected');
    return isVpnConnected;
  }

  @override
  Future<bool?> isProxySet() async {
    final isProxySet = await methodChannel.invokeMethod<bool>('isProxySet');
    return isProxySet;
  }

  @override
  Future<String?> getLocalIpAddress() async {
    final localIpAddress = await methodChannel.invokeMethod<String>('getLocalIpAddress');
    return localIpAddress;
  }

  @override
  Future<bool?> isPublicIP() async {
    final isPublicIP = await methodChannel.invokeMethod<bool>('isPublicIP');
    return isPublicIP;
  }

  @override
  Future<bool?> isVpnUsingNetworkInterface() async {
    final isVpnUsingNetworkInterface = await methodChannel.invokeMethod<bool>('isVpnUsingNetworkInterface');
    return isVpnUsingNetworkInterface;
  }
}
