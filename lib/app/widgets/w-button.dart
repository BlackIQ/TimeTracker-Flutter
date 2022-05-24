import 'package:flutter/material.dart';

class FullButton extends StatelessWidget {
  const FullButton({Key? key, this.text, this.color, this.onClick}) : super(key: key);

  final text;
  final color;
  final onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
        ),
        child: Text(text),
        onPressed: onClick,
      ),
    );
  }
}
