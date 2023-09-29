import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
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
  // final ImagePicker _picker = ImagePicker();

  final String _keyScore = 'score';
  final String _keyImage = 'image';
  final String _keyTanggal = 'date';
  late SharedPreferences prefs;

  TextEditingController datePickerController = TextEditingController();

  bool isLoadingData = true;

  void loadData() async {
    prefs = await SharedPreferences.getInstance();

    await Future.delayed(const Duration(seconds: 3), () {
      print('Wait for 3 seconds');
    });

    setState(() {
      _score = (prefs.getDouble(_keyScore) ?? 0);
      _image = prefs.getString(_keyImage);
      _tanggal = prefs.getString(_keyTanggal);
      datePickerController.text = _tanggal != null ? _tanggal! : 'Tanggal';
      isLoadingData = false;
    });
    print('Data loaded');
  }

  Future<void> _setScore(double value) async {
    print(value);
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setDouble(_keyScore, value);
      _score = (prefs.getDouble(_keyScore) ?? 0);
    });
  }

  // Future<void> _setImage(String? value) async {
  //   prefs = await SharedPreferences.getInstance();
  //   if (value != null) {
  //     setState(() {
  //       prefs.setString(_keyImage, value);
  //       _image = prefs.getString(_keyImage);
  //     });
  //   }
  // }

  Future<void> _setTanggal(String? value) async {
    prefs = await SharedPreferences.getInstance();
    if (value != null) {
      setState(() {
        prefs.setString(_keyTanggal, value);
        _tanggal = prefs.getString(_keyTanggal);
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              isLoadingData
                  ? const Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
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
                        decoration: const BoxDecoration(color: Color.fromARGB(255, 198, 198, 198)),
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
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    TextField(
                      enabled: false,
                      controller: datePickerController,
                      decoration: const InputDecoration(hintText: 'Tanggal'),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                        appBar: AppBar(
                                          title: const Text('Pilih Tanggal'),
                                        ),
                                        body: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SfDateRangePicker(
                                            showActionButtons: true,
                                            initialSelectedDate:
                                                _tanggal != null ? DateTime.parse(_tanggal!) : null,
                                            onCancel: () {
                                              Navigator.pop(context);
                                            },
                                            onSubmit: (value) {
                                              datePickerController.text = value.toString();
                                              _tanggal = value.toString();
                                              _setTanggal(value.toString());
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      )));
                        },
                        child: const Text('Pilih Tanggal'))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      prefs.remove(_keyScore);
                      prefs.remove(_keyTanggal);

                      setState(() {
                        _score = 0;
                        _tanggal = null;
                        datePickerController.text = 'Tanggal';
                      });
                    },
                    child: const Text('Clear Data')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
