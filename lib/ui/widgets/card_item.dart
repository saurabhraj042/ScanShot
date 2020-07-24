import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final IconData startIcon;
  final IconData endIcon;

  const Cards(this.title, {this.onTap, this.startIcon, this.endIcon});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          width: (width * 0.40),
          height: (height* 0.20),
          child: RaisedButton(
            color: Colors.white,
            elevation: 20,
            padding: const EdgeInsets.all(10),
            onPressed: onTap,
            child: Text(title),
          )),
    );
  }
}
