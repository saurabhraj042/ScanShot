import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scan_shot/core/viewmodels/auth_service.dart';

import '../homepage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              width: 250.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: SizedBox(
                      height: 130,
                      width: 250,
                      child: Text(
                        "Hello \nThere,",
                        style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  OutlineButton(
                    borderSide: BorderSide(color: Colors.black),
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: Color(0xffffffff),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.google,
                          color: Color(0xffCE107C),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ),
                      ],
                    ),
                    onPressed: () {
                      auth.signInWithGoogle().whenComplete(() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return HomePage();
                            },
                          ),
                        );
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
