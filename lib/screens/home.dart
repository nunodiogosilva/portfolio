import 'package:flutter/material.dart';
import 'package:portfolio/widgets/responsive.dart';
import 'package:portfolio/screens/devices/desktop/desktop_body.dart';
import 'package:portfolio/screens/devices/mobile/mobile_body.dart';
import 'package:portfolio/screens/devices/phablet/phablet_body.dart';
import 'package:portfolio/screens/devices/tablet/tablet_body.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayout(
        mobile: MobileBody(),
        phablet: PhabletBody(),
        tablet: TabletBody(),
        desktop: DesktopBody(),
      ),
    );
  }
}
