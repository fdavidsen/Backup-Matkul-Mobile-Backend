import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  var _contacts;

  Future<void> getContacts() async {
    List<Contact> contacts = await ContactsService.getContacts();
    print(contacts);
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: _contacts != null && _contacts.length != 0
          ? ListView.builder(
              itemCount: _contacts?.length ?? 0,
              itemBuilder: (context, index) {
                print(index);
                Contact? contact = _contacts?.elementAt(index);

                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                  title: Text(contact.displayName ?? ''),
                );
              })
          : Center(
              child: Text('Kontak Kosong'),
            ),
    );
  }
}
