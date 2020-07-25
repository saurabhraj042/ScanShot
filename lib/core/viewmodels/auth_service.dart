import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scan_shot/ui/views/login/login.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  String name;
  String email;
  String imageUrl;
  // create a getter stream
  Stream<FirebaseUser> get onAuthStateChanged => _auth.onAuthStateChanged;

  //Sign in async functions here ..
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoUrl != null);

    name = user.displayName;
    email = user.email;
    imageUrl = user.photoUrl;

    // Only taking the first part of the name, i.e., First Name
    // if (name.contains(" ")) {
    //   name = name.substring(0, name.indexOf(" "));
    // }

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  Future<Login> signOutGoogle() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    return Login();
    
  }
}
