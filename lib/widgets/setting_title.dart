import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final VoidCallback onTap;
  const SettingTile({Key key, this.title, this.subtitle, this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      leading: Icon(
        icon,
        color: Color(0xff909090),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black87
        )
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle,
              style:TextStyle(
          color: Colors.black87
              ),
            ),
    );
  }
}