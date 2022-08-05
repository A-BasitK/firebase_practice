import 'package:flutter/material.dart';
class CustomNavigationText extends StatelessWidget {
String txt1;
String txt2;
var recognizer;
CustomNavigationText({Key? key, required this.txt1,required this.txt2,required this.recognizer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text:  TextSpan(
            text: txt1,
            style: TextStyle(color: Colors.black, fontSize: 18),
            children: <TextSpan>[
              TextSpan(
                recognizer: recognizer,
                text: txt2,
                style: TextStyle(color: Colors.teal, fontSize: 18,fontWeight: FontWeight.bold),
              )
            ]));
  }
}
