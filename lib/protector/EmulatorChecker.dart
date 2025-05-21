import 'CheckResult.dart';


class EmulatorChecker {
  static const int RESULT_EMULATOR = 2;
  static const int RESULT_UNKNOWN = 0;
  static const int RESULT_MAYBE_EMULATOR = 0;
  static const int THRESHOLD_SCORE = 4;

  final Map<String, dynamic> properties;

  EmulatorChecker(this.properties);

  int evaluateCheckResult(CheckResult result) {
    switch (result.result) {
      case RESULT_EMULATOR:
        return 2;
      case RESULT_MAYBE_EMULATOR:
        return 0;
      default:
        return 1;
    }
  }

  CheckResult checkFeaturesByHardware() {
    final hardware = properties['Hardware']?.toString().toLowerCase();
    if (hardware == null) return CheckResult(RESULT_MAYBE_EMULATOR, null);

    final known = ['ttvm', 'nox', 'cancro', 'intel', 'vbox', 'ranchu', 'vbox86', 'android_x86'];
    return known.contains(hardware)
        ? CheckResult(RESULT_EMULATOR, hardware)
        : CheckResult(RESULT_UNKNOWN, hardware);
  }

  CheckResult checkFeaturesByHost() {
    final host = properties['Host']?.toString().toLowerCase();
    if (host == null) return CheckResult(RESULT_UNKNOWN, null);

    final known = ['dev', 'build2', 'buildbot', 'google_sdk', 'android-build'];
    return known.contains(host)
        ? CheckResult(RESULT_EMULATOR, host)
        : CheckResult(RESULT_UNKNOWN, host);
  }

  CheckResult checkFeaturesByFlavor() {
    final flavor = properties['Flavor']?.toString().toLowerCase();
    if (flavor == null) return CheckResult(RESULT_MAYBE_EMULATOR, null);

    if (flavor.contains('vbox')) return CheckResult(RESULT_EMULATOR, flavor);
    if (flavor.contains('sdk_gphone')) return CheckResult(10, flavor); // custom score
    return CheckResult(RESULT_UNKNOWN, flavor);
  }

  CheckResult checkFeaturesByModel() {
    final model = properties['Model']?.toString().toLowerCase();
    if (model == null) return CheckResult(RESULT_MAYBE_EMULATOR, null);

    if (model.contains('google_sdk') ||
        model.contains('emulator') ||
        model.contains('android sdk built for x86')) {
      return CheckResult(RESULT_EMULATOR, model);
    }
    return CheckResult(RESULT_UNKNOWN, model);
  }

  CheckResult checkFeaturesByManufacturer() {
    final manufacturer = properties['Manufacturer']?.toString().toLowerCase();
    if (manufacturer == null) return CheckResult(RESULT_MAYBE_EMULATOR, null);

    if (manufacturer.contains('genymotion') || manufacturer.contains('netease')) {
      return CheckResult(RESULT_EMULATOR, manufacturer);
    }
    return CheckResult(RESULT_UNKNOWN, manufacturer);
  }

  CheckResult checkFeaturesByBoard() {
    final board = properties['Board']?.toString().toLowerCase();
    if (board == null) return CheckResult(RESULT_MAYBE_EMULATOR, null);

    if (board.contains('android') || board.contains('goldfish')) {
      return CheckResult(RESULT_EMULATOR, board);
    }
    return CheckResult(RESULT_UNKNOWN, board);
  }

  CheckResult checkFeaturesByPlatform() {
    final platform = properties['Platform']?.toString().toLowerCase();
    if (platform == null) return CheckResult(RESULT_MAYBE_EMULATOR, null);

    if (platform.contains('android')) {
      return CheckResult(RESULT_EMULATOR, platform);
    }
    return CheckResult(RESULT_UNKNOWN, platform);
  }

  CheckResult checkFeaturesByBaseBand() {
    final baseBand = properties['BaseBand']?.toString();
    if (baseBand == null) return CheckResult(RESULT_EMULATOR, null);

    if (baseBand.contains('1.0.0.0')) {
      return CheckResult(RESULT_EMULATOR, baseBand);
    }
    return CheckResult(RESULT_UNKNOWN, baseBand);
  }

  CheckResult checkFeaturesByCgroup() {
    final cgroup = properties['Cgroup'];
    if (cgroup == null) return CheckResult(RESULT_MAYBE_EMULATOR, null);

    return CheckResult(RESULT_UNKNOWN, cgroup.toString());
  }

  Map<String, dynamic> analyze() {
    int score = 0;
    final resultMap = <String, dynamic>{};

    final checks = <String, CheckResult>{
      "Hardware": checkFeaturesByHardware(),
      "Host": checkFeaturesByHost(),
      "Flavor": checkFeaturesByFlavor(),
      "Model": checkFeaturesByModel(),
      "Manufacturer": checkFeaturesByManufacturer(),
      "Board": checkFeaturesByBoard(),
      "Platform": checkFeaturesByPlatform(),
      "BaseBand": checkFeaturesByBaseBand(),
      "Cgroup": checkFeaturesByCgroup(),
    };

    for (var entry in checks.entries) {
      resultMap[entry.key] = entry.value.value;
      int valueScore = evaluateCheckResult(entry.value);
      if (entry.key == "BaseBand") {
        score += valueScore * 4; // weighted
      } else {
        score += valueScore;
      }
    }


    // Camera support
    final hasCamera = properties['CameraSupport']?.toString() == 'true';
    resultMap['CameraSupport'] = hasCamera;
    if (!hasCamera) score += 2;

    // Bluetooth support
    final hasBluetooth = properties['BluetoothSupport']?.toString() == 'true';
    resultMap['BluetoothSupport'] = hasBluetooth;
    if (!hasBluetooth) score += 2;

    resultMap['EmulatorScore'] = score;
    resultMap['IsEmulator'] = score >= THRESHOLD_SCORE;

    return resultMap;
  }
}