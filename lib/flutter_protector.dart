
import 'flutter_protector_platform_interface.dart';

class FlutterProtector {
  Future<String?> getPlatformVersion() {
    return FlutterProtectorPlatform.instance.getPlatformVersion();
  }

  Future<bool?> isEmulator() {
    return FlutterProtectorPlatform.instance.isEmulator();
  }
  Future<bool?> isDeviceRooted() {
    return FlutterProtectorPlatform.instance.isDeviceRooted();
  }
 Future<bool?> checkForSniffingApps(List<String> sniffingAppsToCheck) {
    return FlutterProtectorPlatform.instance.checkForSniffingApps(sniffingAppsToCheck);
  }

  Future<bool?> isVpnConnected() {
    return FlutterProtectorPlatform.instance.isVpnConnected();
  }

  Future<bool?> isProxySet() {
    return FlutterProtectorPlatform.instance.isProxySet();
  }

  Future<String?> getLocalIpAddress() {
    return FlutterProtectorPlatform.instance.getLocalIpAddress();
  }

  Future<bool?> isPublicIP() {
    return FlutterProtectorPlatform.instance.isPublicIP();
  }

  Future<bool?> isVpnUsingNetworkInterface() {
    return FlutterProtectorPlatform.instance.isVpnUsingNetworkInterface();
  }
}
