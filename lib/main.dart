import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan_shot/ui/views/login/splash_screen.dart';

import 'core/viewmodels/auth_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MaterialApp(
        title: 'ScanShot',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
