import 'package:flutter/material.dart';
import '../breakpoints.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget phablet;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    required this.phablet,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          if (constraints.maxWidth < phabletWidth) {
            return mobile;
          } else if (constraints.maxWidth < tabletWidth) {
            return phablet;
          } else if (constraints.maxWidth < desktopWidth) {
            return tablet;
          } else {
            return desktop;
          }
        }
    );
  }
}
