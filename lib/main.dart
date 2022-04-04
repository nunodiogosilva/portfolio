import 'package:flutter/material.dart';
import 'package:portfolio/screens/home.dart';

void main() {
  runApp(const Portfolio());
}

class Portfolio extends StatelessWidget {
  const Portfolio({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
