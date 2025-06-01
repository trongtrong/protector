# flutter_protector (0.6.3)

یک افزونه Flutter برای افزایش امنیت اپلیکیشن از طریق بررسی وضعیت دستگاه و پلتفرم

[![pub package](https://img.shields.io/pub/v/flutter_protector)](https://pub.dev/packages/flutter_protector)

---

## 🛡️ معرفی

**flutter_protector** به شما کمک می‌کند تا اپلیکیشن Flutter خود را از طریق بررسی جامع وضعیت امنیتی دستگاه محافظت کنید.  
این پکیج برای تشخیص موارد مشکوک مانند استفاده از پروکسی، VPN، اسنیفینگ، روت/جیلبریک و امولاتور طراحی شده است.

> ⚠️ **نکته مهم:** این پکیج یک لایه امنیتی اضافه می‌کند، اما هیچ راهکاری به‌تنهایی امنیت ۱۰۰٪ تضمین نمی‌کند.  
> لطفاً در کنار این ابزار از روش‌های امنیتی دیگر مانند مخفی‌سازی کد، ذخیره‌سازی رمزگذاری‌شده و اعتبارسنجی سمت سرور نیز استفاده نمایید.

---

## ✨ قابلیت‌ها

| قابلیت | توضیحات |
|--------|---------|
| **تشخیص نسخه سیستم‌عامل** | دریافت نسخه Android یا iOS |
| **تشخیص امولاتور** | بررسی اجرای برنامه روی شبیه‌ساز (Android) |
| **تشخیص روت / جیلبریک** | بررسی روت بودن دستگاه اندروید یا جیلبریک بودن آی‌اواس |
| **تشخیص ابزارهای شنود (Sniffing)** | شناسایی برنامه‌های مشهور اسنیفر مانند Fiddler یا Charles |
| **تشخیص VPN** | بررسی فعال بودن اتصال VPN |
| **تشخیص پروکسی** | بررسی تنظیم بودن پروکسی در دستگاه |
| **آدرس IP محلی** | دریافت IP داخلی دستگاه |
| **تشخیص IP عمومی** | بررسی داشتن IP عمومی |
| **تشخیص اینترفیس VPN** | شناسایی اتصال VPN از طریق بررسی رابط‌های شبکه |
| **تشخیص پلتفرم در وب** | در صورت اجرا روی Web، پلتفرم هدف را شناسایی می‌کند |

---

## 🛠 نصب

در فایل `pubspec.yaml` خود، این پکیج را اضافه کنید:

```yaml
dependencies:
  flutter_protector: ^0.6.3
```

### مثال 

Here's a simple example of how to use `flutter_protector` to gather security-related information:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_protector/flutter_protector.dart';

class InfoResult extends StatefulWidget {
  const InfoResult({Key? key}) : super(key: key);

  @override
  State<InfoResult> createState() => _InfoResultState();
}

class _InfoResultState extends State<InfoResult> {
  final flutterProtector = FlutterProtector();
  Map<String, dynamic> result = {};
  bool loading = true;

  @override
  void initState() {
    super.initState();
    initSecurityInfo();
  }

  Future<void> initSecurityInfo() async {
    final pt = await flutterProtector.checkResultSecurityInfo();
    result = pt!;

    result['Platform Version'] = await flutterProtector.getPlatformVersion();
    result['Checked Root Device'] = await flutterProtector.isDeviceRooted();
    result['Checked Emulator Device'] = await flutterProtector.isEmulatorSuper();
    result['Use Proxy Device'] = await flutterProtector.isProxySet();
    result['Is DeveloperOptions Enabled'] = await flutterProtector.isDeveloperOptionsEnabled();
    result['Is VPN Connected'] = await flutterProtector.isVpnConnected();
    result['Is Sniffing Apps'] = await flutterProtector.checkForSniffingApps([]);
    result['Support Camera Flash'] = await flutterProtector.isCameraFlashAvailable();
    result['Support Bluetooth'] = await flutterProtector.isBluetoothAvailable();
    result['Support Camera'] = await flutterProtector.isCameraAvailable();
    result['Has Light Sensor'] = await flutterProtector.isLightSensorAvailable();
    result['Manufacturer'] = await flutterProtector.getManufacturer();
    result['Model'] = await flutterProtector.getModel();
    result['BaseBand'] = await flutterProtector.getBaseBand();
    result['Board'] = await flutterProtector.getBoard();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Info Security Result")),
      body: loading
          ? Center(child: CircularProgressIndicator(strokeWidth: 1.8))
          : ListView(
              padding: EdgeInsets.all(16),
              children: result.keys.map((key) {
                final value = result[key];
                return ListTile(
                  title: Text(key),
                  trailing: value is bool
                      ? Icon(
                          value ? Icons.check_circle : Icons.cancel,
                          color: value ? Colors.green : Colors.red,
                        )
                      : Text(value?.toString() ?? 'N/A'),
                );
              }).toList(),
            ),
    );
  }
}
```
