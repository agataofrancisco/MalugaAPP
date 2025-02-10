import 'package:flutter/material.dart';
import 'package:flutter_/Components/Colors.dart';
import 'package:flutter_/Components/MyElevatedButton.dart';
import 'package:flutter_/Components/MyTextField.dart';
import 'package:flutter_/db/Database.dart';
import 'package:flutter_/db/Models/MaterialModel.dart';
import 'package:flutter_/pages/Menu.dart';
import 'package:flutter_/pages/empty/material.dart';

class ListThing extends StatefulWidget {
  const ListThing({super.key});

  @override
  State<ListThing> createState() => _ListThingState();
}

class _ListThingState extends State<ListThing>{

  late Future<List<Materialmodel>> _materials;
  List<Materialmodel> materials = [];
  Set<int> selectedmaterials = {};
  Map<int, TextEditingController> quantidadeController = {};

  //CONTROLLERS PARA ADICIONAR INPRODUTOS AO BANCO
  TextEditingController namecontroller = TextEditingController();
    TextEditingController descriptioncontroller = TextEditingController();
    TextEditingController statuscontroller = TextEditingController();
    TextEditingController precocontroller = TextEditingController();
    TextEditingController  quantitycontroller = TextEditingController();
  @override
  
  void initState(){
    super.initState();
    _materials = MalugaDatabase.instance.getAllMaterials('materials').then((data){
      return data.map((item) => Materialmodel.fromMap(item)).toList();
    });
  }
  // Alterna a seleção de um produto
  void _toggleSelection(int materialId) {
    setState(() {
      if (selectedmaterials.contains(materialId)) {
        selectedmaterials.remove(materialId);
      } else {
        selectedmaterials.add(materialId);
        quantidadeController[materialId] = TextEditingController();
      }
    });
  }
  /*
  String formatarPreco(double preco) {
    final formatter = NumberFormat('#,##0.00', 'pt_BR'); // Formato brasileiro
    return formatter.format(preco);
  }
  */
  @override
  Widget build(BuildContext context) {
    //DIALOG BOX TO REGISTER THE ALUGADOR OU KILAPEIRO
  void dialogoKilapeiroCad(/*String nome, String descricao, int  quantidade, String estado, double preco*/){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Insira as informações do Kilapeiro"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                " ALGOFFFFFFFFFFFF",
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              Mytextfield(hintText: "Nome do KILAPEIRO"), MyElevatedbutton(text: "PESSOA", action: (){})
            ],
          ),
          actions: [
            MyElevatedbutton(
              text:'Cadastrar',
              action: (){
                Navigator.of(context).pop();
              }
            ),
            MyElevatedbutton(
              text:'Cancelar',
              action: (){
                Navigator.of(context).pop();
              }
            ),
          ],  
        );

      }
    );
  }
    //DIALOG BOX TO SHOW DE SPECIFICATIONS OF THE MATERIAL
    void dialogoMaterial(String nome, String descricao, int  quantidade, String estado, double preco){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("$nome"),
          content: Text(
            " Quantidade: $quantidade \n Descrição: $descricao\n Estado: $estado\n Preço: $preco",
            style: const TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          actions: [
            MyElevatedbutton(
              text:'Alugar',
              action: (){
                Navigator.of(context).pop();
              }
            ),
            MyElevatedbutton(
              text:'Kilapar',
              action: (){
                Navigator.of(context).pop();
                dialogoKilapeiroCad();

              }
            ),
            MyElevatedbutton(
              text:'Editar',
              action: (){
                Navigator.of(context).pop();
              }
            )
            
          ],  
        );

      }
    );
  }
  ///FUNÇÃO PARA MANDAR OS DADOS PARA O BANCO
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=> Menu()));
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
  
    return FutureBuilder<List<Materialmodel>>(
      future: _materials, 
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else if(snapshot.hasError){
          return Center(child: Text("ERRO ${snapshot.error}"));
        }else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return EmptyMaterial();
        } else {
          final _materials_ = snapshot.data!;
          return Scaffold(
            body: ListView.builder(
              itemCount: _materials_.length,
              itemBuilder: (context, index){
                final material = _materials_[index];
                return GestureDetector(
                  onTap: () {
                    dialogoMaterial(material.name,material.description,material.quantity,material.status,material.price);
                  },
                  child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: BaseColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:
                      ListTile(
                        title:Text(
                          material.name,
                          style:TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ForegroundColor,
                          ),
                        ),
                        subtitle: Text(
                          "${material.description} - ${material.price.toString()}Kz",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                        /*trailing: Text(
                          trallling,
                          style: TextStyle(
                            color: ForegroundColor
                          ),
                        ),*/
                        trailing: Checkbox(
                        value: selectedmaterials.contains(material.id),
                        onChanged: (_) => _toggleSelection(material.id),
                      ),
                      ),
                    ),
                  ),
                )/*MylistTile(
                    titulo: material.name, 
                    subtitulo: material.description, 
                    trallling: material.price.toString()
                  ),*/
                );
              }
            ),
            
            floatingActionButton: selectedmaterials.isNotEmpty ?  Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(onPressed: (){}, child: Icon(Icons.sell,color: ForegroundColor,),backgroundColor:BaseColor,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(onPressed: (){}, child: Icon(Icons.takeout_dining,color: ForegroundColor,),backgroundColor:BaseColor,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(onPressed: (){_AddMaterial();}, child: Icon(Icons.add,color: ForegroundColor,),backgroundColor:BaseColor,),
                ),
              ],
            ) : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(onPressed: (){_AddMaterial();}, child: Icon(Icons.add,color: ForegroundColor,),backgroundColor:BaseColor,),
                ),
          );
          }
        }
    );
  }
    
}