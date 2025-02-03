import 'package:flutter/material.dart';

class MylistTile extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final String trallling;
  
  const MylistTile({super.key, required this.titulo, required this.subtitulo, required this.trallling});

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:
                      ListTile(
                        title:Text(
                          titulo,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          "${subtitulo}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          trallling,
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                );
  }
}