import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scan_shot/core/viewmodels/auth_service.dart';
import 'package:scan_shot/ui/views/login/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScanShot'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.signOutAlt,
            size: 20.0,
            color: Colors.white,
          ),
          onPressed: () {
            _auth.signOutGoogle();
            print('Signed out');
            setState(() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Login();
                  },
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
