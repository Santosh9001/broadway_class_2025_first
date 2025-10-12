import 'package:flutter/material.dart';

class AnimatedContainerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimatedContainerState();
}

class _AnimatedContainerState extends State<AnimatedContainerWidget> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated Container example"),
      ),
      body: Center(
        child: AnimatedCrossFade(
          duration: const Duration(
            milliseconds: 500,
          ),
          firstChild: Container(color: Colors.blue,height: 300,width: 300,),
          secondChild: Container(color: Colors.yellow,height: 200,width: 200,),
          crossFadeState: check ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          check = !check;
        });
      }),
    );
  }
}
