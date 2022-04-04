import 'package:flutter/material.dart';
import 'package:portfolio/widgets/responsive.dart';
import 'package:portfolio/widgets/body/mobile_body.dart';
import 'package:portfolio/widgets/body/tablet_body.dart';
import 'package:portfolio/widgets/body/desktop_body.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

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