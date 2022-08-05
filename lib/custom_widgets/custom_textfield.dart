import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  String hint_text;
  var controller;
  var textInputAction;
  CustomTextField({required this.hint_text, required this.controller,required this.textInputAction});
  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controller,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            hintText: hint_text, border: OutlineInputBorder()));
  }
}
