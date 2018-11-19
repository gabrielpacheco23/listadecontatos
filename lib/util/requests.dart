import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// final url = 'http://localhost:8000';
final url = 'http://10.0.2.2:8000';

Future<List> getContactList() async {
  try {
     var getAllContacts =
         await http.get("${url}/contacts/", headers: {
       "Content-Type": "application/json",
     });
    //var getAllContacts =
    //    await http.get(Uri.http(url, '/contacts/'), headers: {
    //  "Content-Type": "application/json",
    // });

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
  var post = await http.post('${url}/contact/new/',
      headers: {"Content-Type": "application/json"}, body: body);

  if (post.statusCode == 200)
    print('Contact created -> ${post.statusCode}');
  else
    print('Error while creating new contact -> ${post.statusCode}');
}

Future<Map> getContact(int id) async {
  var getContact = await http
      .get('${url}/contact/$id', headers: {"Content-Type": "application/json"});
  var contact = json.decode(getContact.body);
  print(getContact.body);

  return contact;
}
