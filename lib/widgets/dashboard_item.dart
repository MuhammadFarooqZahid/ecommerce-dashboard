import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  final void Function() onTap;
  final String label;
  final Widget icon;
  final String subtitle;
  const DashboardItem({
    required this.onTap,
    required this.label,
    required this.icon,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () {
          onTap();
        },
        horizontalTitleGap: 30,
        title: Text(label),
        subtitle: Text(subtitle),
        leading: icon,
        trailing: Icon(Icons.keyboard_arrow_right_rounded),
      ),
    );
  }
}
