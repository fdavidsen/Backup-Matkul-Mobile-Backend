import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class Home11 extends StatefulWidget {
  const Home11({super.key});

  @override
  State<Home11> createState() => _Home11State();
}

class _Home11State extends State<Home11> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semantic'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Aplikasi Semantics buatan Anak Negeri',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(), labelText: 'Name'.i18n()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  leading: const Icon(Icons.help),
                  title: Text(
                    'Text_call'.i18n(),
                    style: const TextStyle(color: Colors.blue),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text(
                    'johndoe@test.com',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {},
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    }),
                Text('Checkbox-agree'.i18n())
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {}, child: Text('Button-sign-out'.i18n())),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text('Button-sign-in'.i18n())),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
