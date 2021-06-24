import 'package:flutter/material.dart';

showConfirmationDialog(
    BuildContext context, String title, String content) async {
  bool confirm = false;
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        title: Text('$title', style: TextStyle()),
        content: Text(content, style: TextStyle()),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes', style: TextStyle(color: Colors.black87)),
            onPressed: () {
              confirm = true;
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('No', style: TextStyle(color: Colors.black87)),
            onPressed: () {
              confirm = false;
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );

  return confirm;
}