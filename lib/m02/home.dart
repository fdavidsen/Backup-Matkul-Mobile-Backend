import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  String? _image;
  double _score = 0;
  final ImagePicker _picker = ImagePicker();

  final String _keyScore = 'score';
  final String _keyImage = 'image';
  late SharedPreferences prefs;

  void loadData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _score = (prefs.getDouble(_keyScore) ?? 0);
      _image = prefs.getString(_keyImage);
    });
  }

  Future<void> _setScore(double value) async {
    print(value);
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setDouble(_keyScore, value);
      _score = (prefs.getDouble(_keyScore) ?? 0);
    });
  }

  Future<void> _setImage(String? value) async {
    prefs = await SharedPreferences.getInstance();
    if (value != null) {
      setState(() {
        prefs.setString(_keyImage, value);
        _image = prefs.getString(_keyImage);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              Container(
                child: _image != null
                    ? Image.file(
                        File(_image!),
                        width: 200,
                        height: 200,
                      )
                    : Container(
                        width: 200,
                        height: 200,
                        child: Icon(Icons.camera_alt),
                      ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () async {
                    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      if (image != null) {
                        _image = image.path;
                        _setImage(image.path);
                      }
                    });
                  },
                  child: Text('Take Image'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: SpinBox(
                  max: 10,
                  min: 0,
                  value: _score,
                  decimals: 1,
                  step: 0.1,
                  decoration: InputDecoration(labelText: 'Decimals'),
                  onChanged: _setScore,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
