import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/m02/myprovider.dart';
import 'package:flutter_application_1/m03/my_provider.dart';

import 'm02/home-adv.dart';
import 'm02/home.dart';
import 'm03/home.dart';
import 'm04/home.dart';
import 'm05/home.dart';
import 'm06/home.dart';
import 'm07/login.dart';
import 'm09/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MyProvider2()),
      ChangeNotifierProvider(create: (_) => ListProductProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home9(),
    );
  }
}
