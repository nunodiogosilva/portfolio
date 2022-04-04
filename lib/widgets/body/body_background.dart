import 'package:flutter/material.dart';

class BodyBackground extends StatefulWidget {
  final Widget child;

  const BodyBackground({Key? key, required this.child}) : super(key: key);

  @override
  State<BodyBackground> createState() => _BodyBackgroundState();
}

class _BodyBackgroundState extends State<BodyBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff28282a),
            Color(0xff151518),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: widget.child,
    );
  }
}