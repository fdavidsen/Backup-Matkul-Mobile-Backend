import 'package:flutter/material.dart';
import 'package:flutter_application_1/m07/auth.dart';
import 'package:flutter_application_1/m07/login.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key, required this.wid});

  final String wid;

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late AuthFirebase auth;
  String? email;

  @override
  void initState() {
    auth = AuthFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                auth.logout();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home7()));
              },
              icon: Icon(Icons.logout_sharp))
        ],
      ),
      body: Center(
        child: Column(
          children: [Text('Welcome $email'), Text('ID ${widget.wid}')],
        ),
      ),
    );
  }
}
