import 'package:flutter/material.dart';
import 'package:flutter_protector/flutter_protector.dart';
import 'package:flutter_protector_example/security_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale("en"),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SecurityScreen(),
    );
  }
}

