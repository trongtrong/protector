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
  List<Map<String, dynamic>> emulatorDetailsList = [];
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Info Security Result")),
      body: loading
          ? Center(child: CircularProgressIndicator(strokeWidth: 1.8))
          : ListView(
        padding: EdgeInsets.all(5),
        children: [
          _buildTextRow('Platform Version', result['Platform Version']),
          _buildBoolRow('Checked Root Device', result['Checked Root Device']),
          _buildBoolRow('Checked Emulator Device', result['Checked Emulator Device']),
          _buildBoolRow('Use Proxy Device', result['Use Proxy Device']),
          _buildBoolRow('Is DeveloperOptions Enabled', result['Is DeveloperOptions Enabled']),
          _buildBoolRow('Is Sniffing Apps', result['Is Sniffing Apps']),
          _buildBoolRow('Is Vpn Connected', result['Is Vpn Connected']),
          _buildBoolRow('Is BlueStacks', result['Is BlueStacks']),
          _buildBoolRow('Support Camera Flash', result['supportCameraFlash']),
          _buildBoolRow('Support Bluetooth', result['supportBluetooth']),
          _buildBoolRow('Support Camera', result['supportCamera']),
          _buildBoolRow('Has Light Sensor', result['hasLightSensor']),
          _buildTextRow('Platform', result['platform']),
          _buildTextRow('Manufacturer', result['manufacturer']),
          _buildTextRow('Model', result['model']),
          _buildTextRow('BaseBand', result['baseBand']),
          _buildTextRow('Board', result['board']),
          _buildTextRow('suspectCount', result['suspectCount'].toString()),
          _buildTextRow('cgroupResult', result['cgroupResult'].toString()),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 6),
            child: Text('Emulator Details:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          for (var element in emulatorDetailsList)
            _buildEmulatorDetailRow(element['item'], element['isSuspicious'], element['option']),
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
    final resultList = await flutterProtector.emulatorDetails();
    for (var element in resultList!) {
      emulatorDetailsList.add({"item": element['item'], "isSuspicious": element['isSuspicious'], "option": element['option'] ?? ""});
    }
    setState(() {
    });

    final pt = await flutterProtector.checkResultSecurityInfo();
    print(pt);
    result = pt!;

    final pt1 = await flutterProtector.getPlatformVersion();
    result["Platform Version"] = pt1;

    final root = await flutterProtector.isDeviceRooted();
    result["Checked Root Device"] = root;

    final checkEmulator = await flutterProtector.isEmulatorSuper();
    final checkBlueStacks = await flutterProtector.isEmulatorSuper();
    final checkManager = await flutterProtector.isEmulatorSuper();
    result["Checked Emulator Device"] = (checkEmulator! || checkBlueStacks! || checkManager!);

    final setProxy = await flutterProtector.isProxySet();
    result["Use Proxy Device"] = setProxy;

    final isDeveloperOptionsEnabled = await flutterProtector.isDeveloperOptionsEnabled();
    result["Is DeveloperOptions Enabled"] = isDeveloperOptionsEnabled;

    final isVpnConnected = await flutterProtector.isVpnConnected();
    result["Is Vpn Connected"] = isVpnConnected;

    final checkForSniffingApps = await flutterProtector.checkForSniffingApps([]);
    result["Is Sniffing Apps"] = checkForSniffingApps;

    final isBlueStacks = await flutterProtector.isBlueStacks();
    result["Is BlueStacks"] = isBlueStacks;

    setState(() {
      loading = false;
    });
  }

  Widget _buildBoolRow(String title, bool? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Icon(
                value == true ? Icons.check_circle : Icons.cancel,
                color: value == true ? Colors.green : Colors.red,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                value ?? 'N/A',
                style: TextStyle(
                  fontSize: 16,
                  color: value == null || value.isEmpty ? Colors.red : Colors.blueGrey,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.visible,
                maxLines: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmulatorDetailRow(String item, bool isSuspicious, String option) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(!isSuspicious ? Icons.check_circle : Icons.cancel,color: isSuspicious ? Colors.red : Colors.green,size: 20,),
                  SizedBox(width: 4,),
                  Text(
                    'Suspicious: $isSuspicious',
                    style: TextStyle(
                      fontSize: 16,
                      color: isSuspicious ? Colors.red : Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Option: $option',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
