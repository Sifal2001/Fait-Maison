import 'package:flutter/material.dart';

// Wraps screen body with the background + a scrim
class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        color: Colors.white.withOpacity(0.2),
        child: child,
      ),
    );
  }
}