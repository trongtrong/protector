import 'package:flutter/material.dart';
import 'package:flutter_protector/flutter_protector.dart';

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
  String _phoneNumber = 'Unknown';
  String _deviceId = 'Unknown';
  String _imei = 'Unknown';
  bool? _isEmulator = false;
  bool? _isDeviceRooted = false;
  bool? _isVpnConnected = false;
  bool? _isProxySet = false;
  bool? _isDeveloperOptionsEnabled = false;
  String? _localIpAddress = "Unknown";
  bool? _isPublicIP = false;
  bool? _isVpnUsingNetworkInterface = false;
  bool _loading = true;
  Map<dynamic,dynamic> data= {};
  // TargetPlatformProtector _targetPlatformWebLaunchMode = TargetPlatformProtector.unknown;
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
      phoneNumber = 'Failed to get platform version.';
    }
    String? deviceId;
    try {
      deviceId = await _flutterProtectorPlugin.deviceId();
    } catch (e) {
      deviceId = 'Failed to get platform version.';
    }
    String? imei;
    try {
      imei = await _flutterProtectorPlugin.imei();
    } catch (e) {
      imei = 'Failed to get platform version.';
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
    // TargetPlatformProtector targetPlatformWebLaunchMode;
    // try {
    //   targetPlatformWebLaunchMode = await _flutterProtectorPlugin.targetPlatformWebLaunchMode;
    // } catch (e) {
    //   targetPlatformWebLaunchMode = TargetPlatformProtector.unknown;
    // }

     await _flutterProtectorPlugin.getBuildInfo().then((value) {
       print(value);
       data = value!;
    },);

    if (!mounted) return;

    setState(() {
      _phoneNumber = phoneNumber ?? "null";
      _deviceId = deviceId ?? "null";
      _imei = imei ?? "null";
      _platformVersion = platformVersion!;
      _isEmulator = isEmulator;
      _isDeveloperOptionsEnabled = isDeveloperOptionsEnabled;
      _isDeviceRooted = isDeviceRooted;
      _isVpnConnected = isVpnConnected;
      _isProxySet = isProxySet;
      _localIpAddress = localIpAddress;
      _isPublicIP = isPublicIP;
      _isVpnUsingNetworkInterface = isVpnUsingNetworkInterface;
      _loading = false;
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
          child: _loading ? CircularProgressIndicator() : Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('phoneNumber : $_phoneNumber\n'),
                      Text('deviceId : $_deviceId\n'),
                      Text('imei : $_imei\n'),
                      Text('Running on: $_platformVersion\n'),
                      Text('Is Emulator: $_isEmulator\n'),
                      Text('Is Rooted: $_isDeviceRooted\n'),
                      Text('Is VPN Connected: $_isVpnConnected\n'),
                      Text('Is Proxy Set: $_isProxySet\n'),
                      Text('Local IP Address: $_localIpAddress\n'),
                      Text('Is Public IP: $_isPublicIP\n'),
                      Text('Is VPN Using Network Interface: $_isVpnUsingNetworkInterface\n'),
                      Text('Is Enabled Developer Option: $_isDeveloperOptionsEnabled\n'),
                      ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Container(
                          alignment: Alignment.center,
                        child: Wrap(
                          children: [
                            Text(data.keys.toList()[index],style: TextStyle(color:  Colors.red),),
                            Text(" => "),
                            Text(data.values.toList()[index].toString(),style: TextStyle(color:  Colors.blueAccent),),
                          ],
                        ),
                      ),)
          
                    ],
                  ),
                ),
              ),
              TextButton(onPressed: initPlatformState, child: Text("Check Security")),
              // Text('Target Platform Web Launch Mode: $_targetPlatformWebLaunchMode\n'),
            ],
          ),
        ),
      ),
    );
  }
}