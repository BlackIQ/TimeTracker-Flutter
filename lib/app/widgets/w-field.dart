import 'package:flutter/material.dart';

class FullField extends StatelessWidget {
  const FullField({Key? key, this.label, this.hint, this.controller, this.password}) : super(key: key);

  final hint;
  final label;
  final controller;
  final password;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hint,
        // border: const OutlineInputBorder(),
      ),
      obscureText: password,
    );
  }
}
