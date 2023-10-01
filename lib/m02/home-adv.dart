import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Home2Adv extends StatefulWidget {
  const Home2Adv({super.key});

  @override
  State<Home2Adv> createState() => _Home2AdvState();
}

class _Home2AdvState extends State<Home2Adv> {
  String? _image;
  String? _tanggal;
  double _score = 0;

  double _duration = 1;
  bool showImage = false;

  final String _keyScore = 'score';
  final String _keyImage = 'image';
  final String _keyTanggal = 'date';
  late SharedPreferences prefs;

  TextEditingController durationController = TextEditingController();
  TextEditingController datePickerController = TextEditingController();

  bool isLoadingData = true;

  void loadData() async {
    prefs = await SharedPreferences.getInstance();

    await Future.delayed(const Duration(seconds: 1), () {
      print('Wait for 1 seconds');
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

  void _setDuration(double value) async {
    print(value);

    setState(() {
      showImage = false;
    });

    await Future.delayed(Duration(seconds: value.toInt()), () {
      print('Wait for ${value.toInt()} seconds');
    });

    setState(() {
      showImage = true;
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
                child: showImage
                    ? Image.asset(
                        'assets/download.jpeg',
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
              Padding(
                padding: const EdgeInsets.all(8),
                child: SpinBox(
                  max: 10,
                  min: 1,
                  value: _duration,
                  decimals: 1,
                  step: 1,
                  decoration: const InputDecoration(labelText: 'Duration'),
                  onChanged: _setDuration,
                ),
              ),
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
