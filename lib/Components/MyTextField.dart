import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final String hintText;
  final keyboardtype;
  final Controller;
  
  const Mytextfield({super.key, required this.hintText, this.keyboardtype, this.Controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        keyboardType: keyboardtype,
        controller: Controller,
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