import 'package:flutter/material.dart';

class PopUpMenuTile extends StatelessWidget {
  const PopUpMenuTile({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon),
        const SizedBox(width: 8.0),
        Text(
          title,
        ),
      ],
    );
  }
}
