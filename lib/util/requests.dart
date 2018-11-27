import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// final url = 'http://localhost:8000';
final url = 'http://10.0.2.2:8000';

Future<List> getContactList() async {
  try {
     var getAllContacts =
         await http.get("$url/contacts/", headers: {
       "Content-Type": "application/json",
     });

    var contactList = json.decode(getAllContacts.body);
    print(getAllContacts.body);

    return contactList as List;
  } catch (e) {
    print("O erro é: $e");
    return null;
  }
}

Future<void> createNew(String name, String email, String phone) async {
  var payload = {
    "name": name,
    "email": email,
    "phone": phone,
  };

  var body = json.encode(payload);
  var post = await http.post('$url/contact/new/',
      headers: {"Content-Type": "application/json"}, body: body);

  if (post.statusCode == 200)
    print('Contact created -> ${post.statusCode}');
  else
    print('Error while creating new contact -> ${post.statusCode}');
}

Future<Map> getContact(int id) async {
  var getContact = await http
      .get('$url/contact/$id', headers: {"Content-Type": "application/json"});
  var contact = json.decode(getContact.body);
  print(getContact.body);

  return contact;
}

Future<void> updateContact(int id, Map<String, String> payload) async {
  // var payload = {
  //   "name": name,
  //   "email": email,
  //   "phone": phone,
  // };

  var body = json.encode(payload);
  var put = await http.put('$url/contact/$id',
    headers: {"Content-Type": "application/json"},
    body: body);

  if(put.statusCode == 200)
    print('Contact updated -> ${put.statusCode}');
  else
    print('Error while updating contact info -> ${put.statusCode}');
}

Future<bool> deleteContact(int id) async {
  var contact = await getContact(id);
  var del = await http.delete('($url/contact/$id', headers: {"Content-Type": "application/json"});
  if(del.statusCode == 200) {
    print('Contact ${contact["name"]} -> ${contact["phone"]} deleted.');
    return true;
  }
  else return false;
}
