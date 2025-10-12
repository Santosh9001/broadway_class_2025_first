import 'package:boroadwy_2025_session1/hero_animation_one.dart';
import 'package:flutter/material.dart';

class HeroAnimationTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HeroAnimationOne(),
            ),
          ),
        child: Center(
          child: Hero(tag: 'hero-animation', child: Icon(Icons.ac_unit)),
        ),
      ),
    );
  }
}
