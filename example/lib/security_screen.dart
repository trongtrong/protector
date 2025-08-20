import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_protector/flutter_protector.dart';
import 'package:flutter_protector_example/security/info_device.dart';
import 'package:flutter_protector_example/security/info_request.dart';
import 'package:flutter_protector_example/security/info_result.dart';
import 'package:url_launcher/url_launcher.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  Color colorPrime = Colors.blueGrey;
  final ptx = FlutterProtector();
  int countProblem = 0;
  Color private = Colors.red;
  String textPrivate = 'Private';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Center(
          child: Text(textPrivate),
        ),
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final checkEmulator = await ptx.checkEmu();
    final isDeveloper = await ptx.isDeveloperOptionsEnabled();
    final isProxy = await ptx.isProxySet();
    final isDebugAttach = await ptx.isDebugAttach();
    // final checkBlueStacks = await ptx.checkTelephonyManager();
    // final checkManager = await ptx.isBlueStacks();
    // colorPrime =
    //     (checkBlueStacks! || checkManager! || checkEmulator!['IsEmulator'])
    //         ? Colors.red
    //         : Colors.green;
    // countProblem = checkEmulator!['EmulatorScore']!;
    setState(() {
      textPrivate =
          '$checkEmulator\nIsDeveloperOptionsEnabled: $isDeveloper\nIsProxySet: $isProxy';
    });

    print('checkEmulator. ${isDebugAttach}');
  }
}
