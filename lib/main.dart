import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan_shot/ui/views/landing.dart';
import 'core/viewmodels/auth_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MaterialApp(
        title: 'ScanShot',
        debugShowCheckedModeBanner: false,
        home: Landing(),
      ),
    );
  }
}
