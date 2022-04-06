import 'package:flutter/material.dart';
import 'package:portfolio/widgets/responsive.dart';
import 'package:portfolio/widgets/body/mobile_body.dart';
import 'package:portfolio/widgets/body/tablet_body.dart';
import 'package:portfolio/widgets/body/desktop_body.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayout(
        mobile: MobileBody(),
        tablet: TabletBody(),
        desktop: DesktopBody(),
      ),
    );
  }
}
