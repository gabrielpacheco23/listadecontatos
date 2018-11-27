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
        // _controllerName = TextEditingController(text: _contact?.name ?? "");
        // _controllerEmail = TextEditingController(text: _contact?.email ?? "");
        // _controllerTel = TextEditingController(text: _contact?.tel ?? "");
        
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Detalhes do contato"),
                actions: <Widget>[
                    _contact != null ? IconButton(icon: Icon(Icons.more_vert, color:Colors.white),
                        onPressed: () => _delete(),) : null,
                    IconButton(icon: Icon(Icons.done, color: Colors.white), 
                        onPressed: () => _addOrUpdate(),)
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

    void _addOrUpdate() async {
        if(_contact == null) {
            _contact = Contact(_controllerName.text, _controllerName.text, _controllerEmail.text);
            await db.createNew(_contact.name, _contact.email, _contact.tel);
        } else {
            _contact.name = _controllerName.text;
            _contact.email = _controllerEmail.text;
            _contact.tel = _controllerTel.text;
            // await db.createNew(_contact.name, _contact.email, _contact.tel);   

            var info = {
              "name": _contact.name,
              "email": _contact.email,
              "phone": _contact.tel,
            };

            db.updateContact(1, info);         
        }

        print("created.");
    }

    void _delete() async {
      if(_contact == null) {
        return;
      }
      else {
        if(await db.deleteContact(1)) {
          _controllerName.text = '';
          _controllerEmail.text = '';
          _controllerTel.text = '';
        }
      }
    }
}


