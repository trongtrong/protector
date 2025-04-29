



import 'package:flutter/material.dart';
import 'package:flutter_protector/flutter_protector.dart';

class InfoRequest extends StatefulWidget {
  const InfoRequest({super.key});

  @override
  State<InfoRequest> createState() => _InfoRequestState();
}

class _InfoRequestState extends State<InfoRequest> {
  final protector = FlutterProtector();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Information"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Request Details',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'You can request additional information or settings by selecting one of the options below.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              // Request Buttons
              _button(
                title: "Open Developer Options",
                call: () {
                  protector.openDeveloperOption();
                },
              ),
              _button(
                title: "Open VPN Settings",
                call: () {
                  protector.openVpnSettings();
                },
              ),
              _button(
                title: "Open Bluetooth Settings",
                call: () {
                  protector.openBluetoothSettings();
                },
              ),
              _button(
                title: "Open Data Usage Settings",
                call: () {
                  protector.openDataUsageSettings();
                },
              ),
              _button(
                title: "Open Sound Settings",
                call: () {
                  protector.openSoundSettings();
                },
              ),
              _button(
                title: "Open Display Settings",
                call: () {
                  protector.openDisplaySettings();
                },
              ),
              _button(
                title: "Open Battery Settings",
                call: () {
                  protector.openBatteryOptimizationSettings();
                },
              ),
              const SizedBox(height: 20),
              // More Info Section
              const Divider(),
              const SizedBox(height: 10),
              const Text(
                'Need more assistance?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'For any issues, feel free to reach out to support or consult our FAQs.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button({required String title, required VoidCallback call}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: call,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
          backgroundColor:Colors.black
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
