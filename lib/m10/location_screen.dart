import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String data = '';

  Future<void> _initLocationService() async {
    var location = Location();

    var loc = await location.getLocation();
    setState(() {
      data = "Latitude: ${loc.latitude}\nLongitude: ${loc.longitude}";
    });
  }

  @override
  void initState() {
    _initLocationService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
      ),
      body: Center(
        child: Text(data),
      ),
    );
  }
}
