import 'package:flutter/material.dart';

class TextInputs extends StatefulWidget {
  final TextEditingController controller;
  String? hintText;
  bool obscureText;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Function()? onIconButtonPressed;
  final IconData? iconData;
  TextInputs({
    super.key,
    required this.controller,
    this.hintText,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.onIconButtonPressed,
    this.iconData,
  });

  @override
  State<StatefulWidget> createState() => _TextInputState();
}

class _TextInputState extends State<TextInputs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: () => widget.onIconButtonPressed!(),
            icon: Icon(
              widget.iconData,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.black38,
          ),
        ),
        keyboardType: widget.textInputType,
        obscureText: widget.obscureText,
        maxLines: 1,
        textInputAction: widget.textInputAction,
      ),
    );
  }
}
