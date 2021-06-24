import 'package:flutter/material.dart';

class JDButton extends StatelessWidget {
  const JDButton({Key key, this.icon, this.action}) : super(key: key);
  final Icon icon;
  final VoidCallback action;
  @override
  Widget build(BuildContext context) {
  return MaterialButton(
   onPressed:action,
   color: Colors.white,
   padding: EdgeInsets.all(16),
   shape: CircleBorder(),
   child: icon,
    );
  }
}