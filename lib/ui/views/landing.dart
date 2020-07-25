import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan_shot/core/viewmodels/auth_service.dart';
import 'package:scan_shot/ui/views/homepage.dart';
import 'package:scan_shot/ui/views/login/login.dart';

class Landing extends StatefulWidget {
  
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    return StreamBuilder<FirebaseUser>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user == null) {
            return Login();
          }
          return HomePage();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
