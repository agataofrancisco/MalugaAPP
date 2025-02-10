import 'package:flutter/material.dart';
import 'package:flutter_/Components/Colors.dart';
import 'package:flutter_/Components/MyElevatedButton.dart';
import 'package:flutter_/pages/AddThing.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Perfil",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ForegroundColor
          ),
        ),
        backgroundColor: BaseColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: Text("A"),
              ),
            ),
            Text("Nome:  "),
            Text("Localização:"),
            Text("Produtos no alugo: "),
            Text("Produtos no Kilapi: "),
            Text("Classificação:"),
            MyElevatedbutton(
              text: "Adicionar Material",
              action: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (build)=> AddThingPage())
                );
              }
            )
          ],
        )
      ),
    );
  }
}