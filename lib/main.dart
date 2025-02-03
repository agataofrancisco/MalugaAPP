import 'package:flutter/material.dart';
import 'package:flutter_/pages/Menu.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Menu(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}


