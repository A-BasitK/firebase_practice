import 'package:flutter/material.dart';
class CustomButton extends StatefulWidget {
  String txt;
  CustomButton({Key? key, required this.txt}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 100,
      decoration: const BoxDecoration(color: Colors.teal),
      child:  Align(
          alignment: Alignment.center,
          child: Text(widget.txt,
            style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 17),
          )),
    );
  }
}
