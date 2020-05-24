import 'package:flutter/material.dart';

class GPMQuickNavItem {
  const GPMQuickNavItem({
    this.icon,
    this.text,
    this.routeName,
  }) : super();

  final IconData icon;
  final String text;
  final String routeName;
}
