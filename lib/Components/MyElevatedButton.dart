import 'package:flutter/material.dart';

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
          color: Colors.white
        ),
      ),
      style:  ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Colors.blue), 
      ),
    );
  }
}