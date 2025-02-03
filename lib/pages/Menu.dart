import 'package:flutter/material.dart';
import 'package:flutter_/pages/ListThing.dart';
import 'package:flutter_/pages/PendingPage.dart';
import 'package:flutter_/pages/ProfilePage.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Maluga",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              Container(child: Row(
                children: [
                  ElevatedButton.icon(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (build) => ProfilePage()));}, label: Icon(Icons.person, color: Colors.blue,)),
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.notifications, color: Colors.white,)),
                  )
                ],
              )),
              //Icon(Icons.person)
            ],
          ),
          bottom: TabBar(
            tabs:<Widget>[
                Center(
                  child: Icon(Icons.list_outlined,color: Colors.white,size: 30,)
                ),
                /*Center(
                  child: Icon(Icons.note_add_outlined,color: Colors.white,size: 30,)
                ),*/
                Center(
                  child: Icon(Icons.pending_outlined,color: Colors.white,size: 30,)
                ),
                /*Center(
                  child: Icon(Icons.feed_outlined,color: Colors.white,size: 30,)
                ),*/
          ]),
        ),
        body: TabBarView(children: <Widget>[
          ListThing(),
          //AddThingPage(),
          PendingPage(),
          //FeedPage()
        ]),
      ),
    );
  }
}