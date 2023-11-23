import 'dart:convert';
import 'dart:math';

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
  String collectionName = 'event_detail';
  List<EventModel> details = [];

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  Future<void> readData() async {
    await Firebase.initializeApp();
    FirebaseFirestore db = await FirebaseFirestore.instance;
    var data = await db.collection(collectionName).get();

    setState(() {
      details = data.docs.map((doc) => EventModel.fromDocSnapshot(doc)).toList();
    });
  }

  Future<void> addRandomData() async {
    FirebaseFirestore db = await FirebaseFirestore.instance;
    EventModel data = EventModel(
      judul: getRandString(5),
      keterangan: getRandString(30),
      tanggal: getRandString(10),
      isLike: Random().nextBool(),
      pembicara: getRandString(20),
    );
    var result = await db.collection(collectionName).add(data.toMap());
    data.id = result.id;

    setState(() {
      details.add(data);
    });
  }

  Future<void> deleteLastData() async {
    FirebaseFirestore db = await FirebaseFirestore.instance;
    await db.collection(collectionName).doc(details.last.id).delete();

    setState(() {
      details.removeLast();
    });
  }

  Future<void> updateIsLike(int index) async {
    FirebaseFirestore db = await FirebaseFirestore.instance;
    await db.collection(collectionName).doc(details[index].id).update({'is_like': !details[index].isLike});

    setState(() {
      details[index].isLike = !details[index].isLike;
    });
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Firestore'),
      ),
      body: ListView.builder(
          itemCount: details.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              isThreeLine: true,
              value: details[index].isLike,
              title: Text(details[index].judul),
              subtitle: Text('${details[index].keterangan} \nHari : ${details[index].tanggal} \nPembicara : ${details[index].pembicara}'),
              onChanged: (bool? value) {
                updateIsLike(index);
              },
            );
          }),
      floatingActionButton: FabCircularMenuPlus(children: [
        IconButton(
            onPressed: () {
              addRandomData();
            },
            icon: const Icon(Icons.add)),
        IconButton(
            onPressed: () {
              print(details.last.id);
              if (details.last.id != null) {
                deleteLastData();
              }
            },
            icon: const Icon(Icons.minimize)),
      ]),
    );
  }
}
