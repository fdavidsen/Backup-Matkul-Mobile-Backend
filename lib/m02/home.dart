import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  String? _image;
  String? _tanggal;
  double _score = 0;
  final ImagePicker _picker = ImagePicker();

  final String _keyScore = 'score';
  final String _keyImage = 'image';
  final String _keyTanggal = 'date';
  late SharedPreferences prefs;

  TextEditingController datePickerController = TextEditingController();

  void loadData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _score = (prefs.getDouble(_keyScore) ?? 0);
      _image = prefs.getString(_keyImage);
      _tanggal = prefs.getString(_keyTanggal);
      datePickerController.text = _tanggal!;
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

  Future<void> _setTanggal(String? value) async {
    prefs = await SharedPreferences.getInstance();
    if (value != null) {
      setState(() {
        prefs.setString(_keyTanggal, value);
        _tanggal = prefs.getString(_keyTanggal);
        datePickerController.text = _tanggal!;
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
      appBar: AppBar(title: const Text('My Bio')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(color: Colors.red[200]),
                child: _image != null
                    ? Image.file(
                        File(_image!),
                        width: 200,
                        height: 200,
                      )
                    : Container(
                        width: 200,
                        height: 200,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 198, 198, 198)),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8),
              //   child: ElevatedButton(
              //     onPressed: () async {
              //       XFile? image =
              //           await _picker.pickImage(source: ImageSource.gallery);
              //       setState(() {
              //         if (image != null) {
              //           _image = image.path;
              //           _setImage(image.path);
              //         }
              //       });
              //     },
              //     child: const Text('Take Image'),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SpinBox(
                  max: 10,
                  min: 0,
                  value: _score,
                  decimals: 1,
                  step: 0.1,
                  decoration: const InputDecoration(labelText: 'Decimals'),
                  onChanged: _setScore,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    TextField(
                      controller: datePickerController,
                      decoration: InputDecoration(hintText: 'Tanggal'),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                        appBar: AppBar(
                                          title: Text('Pilih Tanggal'),
                                        ),
                                        body: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SfDateRangePicker(
                                            showActionButtons: true,
                                            initialDisplayDate:
                                                DateTime.parse(_tanggal!),
                                            onSubmit: (value) {
                                              print(value);
                                              _setTanggal(value.toString());
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      )));
                        },
                        child: Text('Pilih Tanggal'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
