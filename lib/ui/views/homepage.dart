import 'package:flutter/material.dart';
import 'package:scan_shot/ui/widgets/mainPage_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPageUI(),
    );
  }
}
