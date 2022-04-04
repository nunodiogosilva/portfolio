import 'package:flutter/material.dart';
import 'package:portfolio/widgets/body/body_background.dart';

class MobileBody extends StatelessWidget {
  const MobileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BodyBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Text("Home", style: TextStyle(color: Color(0xffC6CDD2), fontSize: 60),),
        ),
      ),
    );
  }
}