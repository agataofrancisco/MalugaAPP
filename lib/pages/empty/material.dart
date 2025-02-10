import 'package:flutter/material.dart';
import 'package:flutter_/Components/Colors.dart';
import 'package:flutter_/Components/MyElevatedButton.dart';
import 'package:flutter_/Components/MyTextField.dart';
import 'package:flutter_/db/Database.dart';
import 'package:flutter_/pages/ListThing.dart';

class EmptyMaterial extends StatefulWidget {
   EmptyMaterial({super.key});

  @override
  State<EmptyMaterial> createState() => _EmptyMaterialState();
}

class _EmptyMaterialState extends State<EmptyMaterial> {
  //CONTROLLERS PARA ADICIONAR INPRODUTOS AO BANCO
  TextEditingController namecontroller = TextEditingController();

    TextEditingController descriptioncontroller = TextEditingController();

    TextEditingController statuscontroller = TextEditingController();

    TextEditingController precocontroller = TextEditingController();

    TextEditingController  quantitycontroller = TextEditingController();

  @override
  //FUNÇÃO PARA MANDAR OS DADOS PARA O BANCO
  void _Inserir() async{
    final db = await MalugaDatabase.instance;
      //db.printTableData('materials');
      //PREPARING ALL DATA TO BE SENT TO THE DB
      final material = {
        'name':namecontroller.text,
        'description': descriptioncontroller.text,
        'quantity': quantitycontroller.text,
        'status': statuscontroller.text,
        'price': precocontroller.text
      };

      //VERIFICATIONS TO MAKE SURE ALL THE FIELDS ARE FIELDS
      if(namecontroller.text == '' || descriptioncontroller.text == '' || quantitycontroller.text == '' || statuscontroller.text == '' ||precocontroller.text == ''){
        //MESSAGE TO INFORM THE USER TO FILL ALL THE FIELD
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: 
        Text(
          "Preencha todos os campos",
          style:  TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.amber,
        ),
      );
      } else {
        //IF EVERYTHING IS RIGTH THE DATA IS ADDED
        await db.insert('materials', material);

        //AFTER ADDING, DELETE EVERYTHING IN THE FIELDS
        namecontroller.clear();
        descriptioncontroller.clear();
        quantitycontroller.clear();
        statuscontroller.clear();
        precocontroller.clear();

        //MESSAGE TO INFORM THAT THE DATA WAS INSERT
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: 
        Text(
          "Material adicionado com sucesso!",
          style:  TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=> ListThing()));
      }
  }
  //DIALOG PARA INSERIR OS DADOS DOS MATERIAIS PRODUTOS AO BANCO
  void _AddMaterial() async{
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Adicione produtos ao banco", style: TextStyle(
          fontSize: 17
        ),),
        content:SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Mytextfield(hintText: "Nome",Controller: namecontroller,),
              Mytextfield(hintText: "Descrição", Controller: descriptioncontroller,),
              Mytextfield(hintText: "Quantidade", Controller: quantitycontroller,keyboardtype: TextInputType.numberWithOptions(),),
              Mytextfield(hintText: "Estado", Controller: statuscontroller,),
              Mytextfield(hintText: "Preço", Controller: precocontroller,keyboardtype: TextInputType.numberWithOptions(),)
            ],
          ),
        ),
        actions:[

          MyElevatedbutton(
            text: "Adicionar", 
            action: (){
              _Inserir();
            }
          ),
        ],
        );
      });
      
    }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Nenhum material encontrado"),
      ),
        floatingActionButton:  FloatingActionButton(onPressed: (){}, child: Icon(Icons.add,color: ForegroundColor,),backgroundColor:BaseColor,),

    );
  }
}