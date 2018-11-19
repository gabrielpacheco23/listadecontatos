import 'package:flutter/material.dart';
import 'package:listadecontatos/models/contact.dart';
import 'package:listadecontatos/util/requests.dart' as db;

class Detail extends StatelessWidget {
    Contact _contact;
    TextEditingController _controllerName;
    TextEditingController _controllerEmail;
    TextEditingController _controllerTel;
    
    Detail({contact}) {
        _contact = contact;
        _controllerName = TextEditingController(text: _contact?.name ?? "");
        _controllerEmail = TextEditingController(text: _contact?.email ?? "");
        _controllerTel = TextEditingController(text: _contact?.tel ?? "");
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Detalhes do contato"),
                actions: <Widget>[
                    IconButton(icon: Icon(Icons.done, color: Colors.white), 
                        onPressed: () => _addContact(),)
                ],
            ),
            body: Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                    children: <Widget>[
                        TextField(
                            decoration: InputDecoration(labelText: "Nome"),
                            maxLines: 1,
                            controller: _controllerName
                        ),
                        TextField(
                            decoration: InputDecoration(labelText: "Email"),
                            maxLines: 1,
                            controller: _controllerEmail
                        ),
                        TextField(
                            decoration: InputDecoration(labelText: "Telefone"),
                            maxLines: 1,
                            controller: _controllerTel
                        )
                    ],
                ),
            ),
        );
    }

    void _addContact() async {
        if(_contact == null) {
            _contact = Contact(_controllerName.text, _controllerName.text, _controllerEmail.text);
        } else {
            _contact.name = _controllerName.text;
            _contact.email = _controllerEmail.text;
            _contact.tel = _controllerTel.text;            
        }

        await db.createNew(_contact.name, _contact.email, _contact.tel);
        print("created.");
    }
}