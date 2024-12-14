import 'package:flutter/material.dart';

class NavbarItem extends StatelessWidget {

  final IconData icon;
  final String label;

  const NavbarItem ({
    super.key,
    required this.icon,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          Text(label)
        ],
      ),
    );
  }
}