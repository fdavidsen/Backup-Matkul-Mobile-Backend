import 'package:flutter/material.dart';

class MyProvider2 extends ChangeNotifier {
  String? _tanggal;
  double _score = 0;

  bool _isLoadingData = true;

  get tanggal => _tanggal;
  set tanggal(value) {
    _tanggal = value;
    notifyListeners();
  }

  get score => _score;
  set score(value) {
    _score = value;
    notifyListeners();
  }

  get isLoadingData => _isLoadingData;
  set isLoadingData(value) {
    _isLoadingData = value;
    notifyListeners();
  }
}
