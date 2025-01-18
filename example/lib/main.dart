import 'package:flutter/material.dart';
import 'package:flutter_protector/flutter_protector.dart';
import 'package:flutter_protector_example/security_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SecurityScreen());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterProtectorPlugin = FlutterProtector();
  String _platformVersion = 'Unknown';
  String _phoneNumber = 'Unknown';
  String _deviceId = 'Unknown';
  String _imei = 'Unknown';
  bool? _isEmulator = false;
  bool? _isEmulator2 = false;
  bool? _isDeviceRooted = false;
  bool? _isVpnConnected = false;
  bool? _isProxySet = false;
  bool? _isDeveloperOptionsEnabled = false;
  String? _localIpAddress = "Unknown";
  bool? _isPublicIP = false;
  bool? _isVpnUsingNetworkInterface = false;
  bool _loading = true;
  Map<dynamic, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    setState(() {
      _loading = true;
    });

    String? platformVersion;
    try {
      platformVersion = await _flutterProtectorPlugin.getPlatformVersion();
    } catch (e) {
      platformVersion = 'Failed to get platform version.';
    }

    String? phoneNumber;
    try {
      phoneNumber = await _flutterProtectorPlugin.phoneNumber();
    } catch (e) {
      phoneNumber = 'Failed to get phone number.';
    }

    String? deviceId;
    try {
      deviceId = await _flutterProtectorPlugin.deviceId();
    } catch (e) {
      deviceId = 'Failed to get device ID.';
    }

    String? imei;
    try {
      imei = await _flutterProtectorPlugin.imei();
    } catch (e) {
      imei = 'Failed to get IMEI.';
    }

    bool? isEmulator;
    try {
      isEmulator = await _flutterProtectorPlugin.isEmulatorOld();
    } catch (e) {
      isEmulator = false;
    }

    bool? isEmulator2;
    try {
      isEmulator2 = await _flutterProtectorPlugin.isEmulatorSuper();
    } catch (e) {
      isEmulator2 = false;
    }

    bool? isDeviceRooted;
    try {
      isDeviceRooted = await _flutterProtectorPlugin.isDeviceRooted();
    } catch (e) {
      isDeviceRooted = false;
    }

    bool? isVpnConnected;
    try {
      isVpnConnected = await _flutterProtectorPlugin.isVpnConnected();
    } catch (e) {
      isVpnConnected = false;
    }

    bool? isProxySet;
    try {
      isProxySet = await _flutterProtectorPlugin.isProxySet();
    } catch (e) {
      isProxySet = false;
    }

    bool? isDeveloperOptionsEnabled;
    try {
      isDeveloperOptionsEnabled = await _flutterProtectorPlugin.isDeveloperOptionsEnabled();
    } catch (e) {
      isDeveloperOptionsEnabled = false;
    }

    String? localIpAddress;
    try {
      localIpAddress = await _flutterProtectorPlugin.getLocalIpAddress();
    } catch (e) {
      localIpAddress = "Unknown";
    }

    bool? isPublicIP;
    try {
      isPublicIP = await _flutterProtectorPlugin.isPublicIP();
    } catch (e) {
      isPublicIP = false;
    }

    bool? isVpnUsingNetworkInterface;
    try {
      isVpnUsingNetworkInterface = await _flutterProtectorPlugin.isVpnUsingNetworkInterface();
    } catch (e) {
      isVpnUsingNetworkInterface = false;
    }

    await _flutterProtectorPlugin.checkResultSecurityInfo().then((value) {
      setState(() {
        data = value ?? {};
      });
    });

    if (!mounted) return;

    setState(() {
      _phoneNumber = phoneNumber ?? "null";
      _deviceId = deviceId ?? "null";
      _imei = imei ?? "null";
      _platformVersion = platformVersion!;
      _isEmulator = isEmulator;
      _isEmulator2 = isEmulator2;
      _isDeveloperOptionsEnabled = isDeveloperOptionsEnabled;
      _isDeviceRooted = isDeviceRooted;
      _isVpnConnected = isVpnConnected;
      _isProxySet = isProxySet;
      _localIpAddress = localIpAddress;
      _isPublicIP = isPublicIP;
      _isVpnUsingNetworkInterface = isVpnUsingNetworkInterface;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PuzzleTak Flutter Protector App'),
        ),
        body: Center(
          child: _loading
              ? CircularProgressIndicator()
              : SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                TextButton(
                  onPressed: () async {
                    await _flutterProtectorPlugin.screenshotSecurity(true);
                  },
                  child: const Text('Enable Screenshot'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await _flutterProtectorPlugin.screenshotSecurity(false);
                  },
                  child: const Text('Disable Screenshot'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                ),
                _buildInfoCard('Phone Number', _phoneNumber),
                _buildInfoCard('Device ID', _deviceId),
                _buildInfoCard('IMEI', _imei),
                _buildInfoCard('Platform Version', _platformVersion),
                _buildInfoCard('Is Emulator', _isEmulator.toString()),
                _buildInfoCard('Is Emulator 2', _isEmulator2.toString()),
                _buildInfoCard('Is Device Rooted', _isDeviceRooted.toString()),
                _buildInfoCard('Is VPN Connected', _isVpnConnected.toString()),
                _buildInfoCard('Is Proxy Set', _isProxySet.toString()),
                _buildInfoCard('Local IP Address', _localIpAddress ?? 'Unknown'),
                _buildInfoCard('Is Public IP', _isPublicIP.toString()),
                _buildInfoCard('Is VPN Using Network Interface', _isVpnUsingNetworkInterface.toString()),
                _buildInfoCard('Is Developer Options Enabled', _isDeveloperOptionsEnabled.toString()),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: initPlatformState,
                  child: const Text('Check Security'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                ),
                const SizedBox(height: 20),
                if (data.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data.entries
                        .map((entry) => ListTile(
                      title: Text(entry.key.toString(), style: TextStyle(color: Colors.red)),
                      subtitle: Text(entry.value.toString(), style: TextStyle(color: Colors.blueAccent)),
                    ))
                        .toList(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12.0),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}
