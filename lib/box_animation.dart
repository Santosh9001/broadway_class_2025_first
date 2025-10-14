// Ticker => tells the flutter framework to redraw a frame on each animation ~ 60 times/sec vsync
import 'package:esewa_flutter/esewa_flutter.dart';
import 'package:flutter/material.dart';

class BoxAnimationEg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoxAnimationState();
}

// class -> extends
// interface -> implements
// mixin -> with
class _BoxAnimationState extends State<BoxAnimationEg>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );

    _animation = Tween<double>(begin: 100, end: 200)
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotationTransition(
          turns: _controller,
          // animation: _animation,
          child: Container(
            width: _animation.value,
            height: _animation.value,
            color: Colors.green,
            child: EsewaPayButton(
              paymentConfig: ESewaConfig.dev(
                amount: 100.0,
                successUrl: 'https://developer.esewa.com.np/success',
                failureUrl: 'https://developer.esewa.com.np/failure',
                secretKey: '8gBm/:&EnhH.1/q',
                // productCode: 'EPAYTEST', // optional for dev (defaults to EPAYTEST)
              ),
              onSuccess: (resp) {
                // resp.data is base64 string
                print('Success base64: ${resp.data}');
              },
              onFailure: (message) {
                print('Failed: $message');
              },
            ),
          ),
        ),
      ),
    );
  }
}
