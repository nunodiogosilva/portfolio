import 'package:flutter/material.dart';
import '../breakpoints.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          if (constraints.maxWidth < tabletWidth) {
            return mobile;
          } else if (constraints.maxWidth < desktopWidth) {
            return tablet;
          } else {
            return desktop;
          }
        }
    );
  }
}
