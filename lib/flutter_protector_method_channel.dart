

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
  Future<bool?> isDeveloperOptionsEnabled() async {
    final check = await methodChannel.invokeMethod<bool>('isDeveloperOptionsEnabled');
    return check;
  }
  @override
  Future<String?> phoneNumber() async {
    final check = await methodChannel.invokeMethod<String>('phoneNumber');
    return check;
  }

  @override
  Future<String?> deviceId() async {
    final check = await methodChannel.invokeMethod<String>('deviceId');
    return check;
  }
  @override
  Future<String?> imei() async {
    final check = await methodChannel.invokeMethod<String>('imei');
    return check;
  }

  @override
  Future<bool?> isEmulatorOld() async {
    final isEmulator = await methodChannel.invokeMethod<bool>('isEmulator');
    return isEmulator;
  }
  @override
  Future<Map<String, dynamic>?> checkResultSecurityInfo() async {
    try {
      final result = await methodChannel.invokeMethod('checkResultSecurityInfo');

      // Ensure result is of the correct type before casting
      if (result is Map) {
        return Map<String, dynamic>.from(result);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching build info: $e");
      return null;
    }
  }

  @override
  Future<int?> checkResultSecurity() async {
    final isEmulator = await methodChannel.invokeMethod<int>('checkResultSecurity');
    return isEmulator;
  }
  @override
  Future<bool?> isEmulatorSuper() async {
    final isEmulator = await methodChannel.invokeMethod<bool>('isEmulatorSuper');
    return isEmulator;
  }
  @override
  Future<Map<String, dynamic>?> getBuildInfo() async {
    try {
      final result = await methodChannel.invokeMethod<Map<dynamic, dynamic>>('getBuildInfo');
      return Map<String, dynamic>.from(result ?? {});
    } catch (e) {
      print("Error fetching build info: $e");
      return null;
    }
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
  Future<bool?> screenshotSecurity(bool enable ) async {
    final screenshotSecuritys = await methodChannel.invokeMethod<bool>('screenshotSecurity',enable);
    return screenshotSecuritys;
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
