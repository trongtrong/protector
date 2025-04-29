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
        padding: EdgeInsets.all(6),
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
      padding: const EdgeInsets.symmetric(vertical: 6.0),
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
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  color: value == null || value.isEmpty ? Colors.red : Colors.blueGrey,
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
