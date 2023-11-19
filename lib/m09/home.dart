import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/m09/event_model.dart';

class Home9 extends StatefulWidget {
  const Home9({super.key});

  @override
  State<Home9> createState() => _Home9State();
}

class _Home9State extends State<Home9> {
  List<EventModel> details = [];

  Future readData() async {
    await Firebase.initializeApp();
    FirebaseFirestore db = await FirebaseFirestore.instance;
    var data = await db.collection('event_detail').get();
    print(data);
    setState(() {
      details = data.docs.map((doc) => EventModel.fromDocSnapshot(doc)).toList();
    });
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(details);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloud Firestore'),
      ),
      body: ListView.builder(
          itemCount: details.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              value: null,
              title: Text(details[index].judul),
              onChanged: (bool? value) {},
            );
          }),
      floatingActionButton: FabCircularMenuPlus(children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.add)),
        IconButton(onPressed: () {}, icon: Icon(Icons.add)),
      ]),
    );
  }
}
