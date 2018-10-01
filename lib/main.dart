import 'package:flutter/material.dart';
import 'package:listadecontatos/widgets/details.dart';
import 'package:listadecontatos/widgets/list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda de Contatos',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de contatos"),
      ),
      body: ContactList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: () {
          _goToContact();
          print("FloatButton");
        },
      ),
      bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Todos")),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          title: Text("Favoritos"),
        )
      ]),
    );
  }

  void _goToContact() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Detail()));
  }
}
