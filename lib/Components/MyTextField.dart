import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final String hintText;
  final keyboardtype;
  final controller;
  
  const Mytextfield({super.key, required this.hintText, this.keyboardtype, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        keyboardAppearance: keyboardtype,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        /*
        inputFormatters: [
          // Permitir números, pontos e vírgulas
          FilteringTextInputFormatter.allow(RegExp(r'^\d*[\.,]?\d*')),
        ],
        */
      ),
    );
  }
}