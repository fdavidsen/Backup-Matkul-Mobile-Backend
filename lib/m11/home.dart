import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Home11 extends StatefulWidget {
  const Home11({super.key});

  @override
  State<Home11> createState() => _Home11State();
}

class _Home11State extends State<Home11> {
  var location;
  Future _initLocationService() async {
    location = Location();

    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return;
      }
    }

    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return;
      }
    }

    var loc = await location.getLocation();
    print("${loc.latitude} ${loc.longitude}");
  }

  @override
  void initState() {
    _initLocationService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    location.onLocationChanged.listen((LocationData loc) {
      print("${loc.latitude} ${loc.longitude}");
    });
    bool _isChecked = false;

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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Isikan Nama'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text(
                    'Hubungi',
                    style: TextStyle(color: Colors.blue),
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
                Text('Setuju')
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
                  child: ElevatedButton(onPressed: () {}, child: Text('Masuk')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      ElevatedButton(onPressed: () {}, child: Text('Keluar')),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
