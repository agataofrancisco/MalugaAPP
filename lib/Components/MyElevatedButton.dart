import 'package:flutter/material.dart';
import 'package:flutter_/Components/Colors.dart';

class MyElevatedbutton extends StatelessWidget {
  final String text;
  final action;

  MyElevatedbutton({super.key, required this.text, required this.action});

  @override
  Widget build(BuildContext context,) {
    return ElevatedButton(
      onPressed: action,
      child: Text(
        text,
        style: TextStyle(
          color: ForegroundColor
        ),
      ),
      style:  ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(BaseColor), 
      ),
    );
  }
}