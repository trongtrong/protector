import 'package:flutter/material.dart';
import 'package:flutter_protector/flutter_protector.dart';

class InfoResult extends StatefulWidget {
  const InfoResult({super.key});

  @override
  State<InfoResult> createState() => _InfoResultState();
}

class _InfoResultState extends State<InfoResult> {
  final flutterProtector = FlutterProtector();
  Map<String, dynamic> result = {};
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Info Security Result")),
      body: loading ? Center(child: CircularProgressIndicator(strokeWidth: 1.8,),) : ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildTextRow('Platform Version', result['Platform Version']),
          _buildBoolRow('Checked Root Device', result['Checked Root Device']),
          _buildBoolRow('Checked Emulator Device', result['Checked Emulator Device']),
          _buildBoolRow('Use Proxy Device', result['Use Proxy Device']),
          _buildBoolRow('Is DeveloperOptions Enabled', result['Is DeveloperOptions Enabled']),
          _buildBoolRow('Is Sniffing Apps', result['Is Sniffing Apps']),
          _buildBoolRow('Is Vpn Connected', result['Is Vpn Connected']),
          _buildBoolRow('Support Camera Flash', result['supportCameraFlash']),
          _buildBoolRow('Support Bluetooth', result['supportBluetooth']),
          _buildBoolRow('Support Camera', result['supportCamera']),
          _buildBoolRow('Has Light Sensor', result['hasLightSensor']),
          _buildTextRow('Platform', result['platform']),
          _buildTextRow('Manufacturer', result['manufacturer']),
          _buildTextRow('Model', result['model']),
          _buildTextRow('BaseBand', result['baseBand']),
          _buildTextRow('Board', result['board']),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final pt = await flutterProtector.checkResultSecurityInfo();
    result = pt!;


    final pt1 = await flutterProtector.getPlatformVersion();
    result["Platform Version"] = pt1;


    final root = await flutterProtector.isDeviceRooted();
    result["Checked Root Device"] = root;


    final isEmulator = await flutterProtector.isEmulatorSuper();
    result["Checked Emulator Device"] = isEmulator;


    final setProxy = await flutterProtector.isProxySet();
    result["Use Proxy Device"] = setProxy;


    final isDeveloperOptionsEnabled = await flutterProtector.isDeveloperOptionsEnabled();
    result["Is DeveloperOptions Enabled"] = isDeveloperOptionsEnabled;


    final isVpnConnected = await flutterProtector.isVpnConnected();
    result["Is Vpn Connected"] = isVpnConnected;



    final checkForSniffingApps = await flutterProtector.checkForSniffingApps([]);
    result["Is Sniffing Apps"] = checkForSniffingApps;


    setState(() {
      loading = false;

    });
  }

  Widget _buildBoolRow(String title, bool? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          Icon(
            value == true ? Icons.check_circle : Icons.cancel,
            color: value == true ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildTextRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 150,),
          Flexible(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(fontSize: 14, color: Colors.blueGrey),
            ),
          ),
        ],
      ),
    );
  }
}
