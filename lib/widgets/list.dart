import 'package:flutter/material.dart';
import 'package:listadecontatos/models/contact.dart';
import 'package:listadecontatos/widgets/details.dart';
import 'package:listadecontatos/util/requests.dart' as db;

class ContactList extends StatefulWidget {
  @override
  createState() => ContactState();
}

class ContactState extends State<ContactList> {
  List<Contact> _contacts = List<Contact>();

  ContactState() {
    // _contacts = [];
    populateList();

    // _contacts.add(Contact("Teste 1", "12345678", "teste1@teste.com"));
    // _contacts.add(Contact("Teste 2", "5242364", "teste2@teste.com"));
    // _contacts.add(Contact("Teste 3", "98521452", "teste3@teste.com"));
  }

  // @override
  // void initState() {
  //     populateList();
  //     super.initState();
  //   }

  @override
  Widget build(BuildContext context) {
    return listar();
  }

  Widget listar() {
    return Container(
        child: ListView.builder(
      itemCount: _contacts.length,
      itemBuilder: (context, i) {
        //if(i.isOdd) Divider();
        return _buildTile(_contacts[i]);
      },
    ));
  }

  Widget _buildTile(Contact element) {
    return ListTile(
        title: Text("${element.name}"),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Detail(contact: element)));
        });
  }

  populateList() async {
    var list = await db.getContactList();
    var contacts = List<Contact>();

    for(var c in list) {
      contacts.add(Contact(c["name"], c["phone"], c["email"]));
      print('nome: ${c["name"]}');
    }

    setState(() {
          if((contacts?.length ?? 0) > 0) _contacts = contacts;
          else _contacts = List<Contact>()..add(Contact("null", "null", "null"));
        });



  }
}
