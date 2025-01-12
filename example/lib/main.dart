import 'package:flutter/material.dart';
import 'package:flutter_protector/flutter_protector.dart';
import 'package:flutter_protector/target_platform_protector.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterProtectorPlugin = FlutterProtector();
  String _platformVersion = 'Unknown';
  bool? _isEmulator = false;
  bool? _isDeviceRooted = false;
  bool? _isVpnConnected = false;
  bool? _isProxySet = false;
  String? _localIpAddress = "Unknown";
  bool? _isPublicIP = false;
  bool? _isVpnUsingNetworkInterface = false;
  // TargetPlatformProtector _targetPlatformWebLaunchMode = TargetPlatformProtector.unknown;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String? platformVersion;
    try {
      platformVersion = await _flutterProtectorPlugin.getPlatformVersion();
    } catch (e) {
      platformVersion = 'Failed to get platform version.';
    }
    bool? isEmulator;
    try {
      isEmulator = await _flutterProtectorPlugin.isEmulator();
    } catch (e) {
      isEmulator = false;
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
    // TargetPlatformProtector targetPlatformWebLaunchMode;
    // try {
    //   targetPlatformWebLaunchMode = await _flutterProtectorPlugin.targetPlatformWebLaunchMode;
    // } catch (e) {
    //   targetPlatformWebLaunchMode = TargetPlatformProtector.unknown;
    // }


    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion!;
      _isEmulator = isEmulator;
      _isDeviceRooted = isDeviceRooted;
      _isVpnConnected = isVpnConnected;
      _isProxySet = isProxySet;
      _localIpAddress = localIpAddress;
      _isPublicIP = isPublicIP;
      _isVpnUsingNetworkInterface = isVpnUsingNetworkInterface;
      // _targetPlatformWebLaunchMode = targetPlatformWebLaunchMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PuzzleTak Flutter Protector app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              Text('Is Emulator: $_isEmulator\n'),
              Text('Is Rooted: $_isDeviceRooted\n'),
              Text('Is VPN Connected: $_isVpnConnected\n'),
              Text('Is Proxy Set: $_isProxySet\n'),
              Text('Local IP Address: $_localIpAddress\n'),
              Text('Is Public IP: $_isPublicIP\n'),
              Text('Is VPN Using Network Interface: $_isVpnUsingNetworkInterface\n'),
              Text('Target Platform Web Launch Mode: $_targetPlatformWebLaunchMode\n'),
            ],
          ),
        ),
      ),
    );
  }
}