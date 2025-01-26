import 'package:flutter/material.dart';
import 'package:flutter_protector/flutter_protector.dart';

class InfoDevice extends StatefulWidget {
  const InfoDevice({super.key});

  @override
  State<InfoDevice> createState() => _InfoDeviceState();
}

class _InfoDeviceState extends State<InfoDevice> {
  final flutterProtector = FlutterProtector();
  Map<String, dynamic> result = {};
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Info Device")),
      body: loading ? Center(child: CircularProgressIndicator(strokeWidth: 1.8,),) : ListView(
        padding: EdgeInsets.all(16),
        children: [
          ...result.keys.map((value) => _buildTextRow(value, result[value].toString()),),
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
    final pt = await flutterProtector.getBuildInfo();
    setState(() {
      loading = false;
      result = pt!;
    });
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
          SizedBox(width: 15,),
          Flexible(
            child: Text(
              value ?? 'N/A',
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 14, color: Colors.blueGrey),
            ),
          ),
        ],
      ),
    );
  }
}
