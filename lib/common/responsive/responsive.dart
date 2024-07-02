// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });
  final Widget mobile, desktop;
  final Widget? tablet;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 500;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width > 500 &&
      MediaQuery.of(context).size.width <= 1100;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1100;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (size.width > 1100) {
      return desktop;
    } else if (size.width < 1100 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
