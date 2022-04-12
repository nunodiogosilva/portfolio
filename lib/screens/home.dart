import 'package:flutter/material.dart';
import 'package:portfolio/widgets/responsive.dart';
import 'package:portfolio/widgets/devices/mobile_body.dart';
import 'package:portfolio/widgets/devices/tablet_body.dart';
import 'package:portfolio/widgets/devices/phablet_body.dart';
import 'package:portfolio/widgets/devices/desktop_body.dart';

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
