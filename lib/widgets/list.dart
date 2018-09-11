import 'package:flutter/material.dart';
import 'package:listadecontatos/models/contact.dart';
import 'package:listadecontatos/widgets/detalhes.dart';

class ContactList extends StatefulWidget {
    @override
    createState() => ContactState();
}

class ContactState extends State<ContactList>{
    List<Contact> _contacts = List<Contact>();

    ContactState() {
        _contacts.add(Contact("Teste 1", "12345678", "teste1@teste.com"));
        _contacts.add(Contact("Teste 2", "5242364", "teste2@teste.com"));
        _contacts.add(Contact("Teste 3", "98521452", "teste3@teste.com"));
    }

    @override
    Widget build(BuildContext context) {
        return contactList();
    }

    Widget contactList() {
        return Container(
            child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, i) {
                    //if(i.isOdd) Divider();
                    return _buildTile(_contacts[i]); 
                },
            )
        );
    }

    Widget _buildTile(Contact element) {
        return ListTile(
            title: Text("${element.name}"), 
            onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Detail(contact: element)
                ));
            }
        );
    }
}