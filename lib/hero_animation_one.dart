import 'package:boroadwy_2025_session1/hero_animation_two.dart';
import 'package:flutter/material.dart';

class HeroAnimationOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HeroAnimationTwo(),
            ),
          ),
          child: Hero(
            tag: 'hero-animation',
            child: Icon(
              Icons.abc,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
