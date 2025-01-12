
import 'flutter_protector_platform_interface.dart';

class FlutterProtector {
  Future<String?> getPlatformVersion() {
    return FlutterProtectorPlatform.instance.getPlatformVersion();
  }
  Future<bool?> isEmulator() {
    return FlutterProtectorPlatform.instance.isEmulator();
  }
}
