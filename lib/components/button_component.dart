import 'package:flutter/material.dart';

class ButtonComponent extends StatefulWidget {
  final String buttonText;
  final Function() onButtonPressed;
  const ButtonComponent({
    super.key,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  State<StatefulWidget> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => widget.onButtonPressed(),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 10,
          ),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.buttonText,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
