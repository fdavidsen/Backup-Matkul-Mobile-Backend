import 'package:flutter/material.dart';
import 'package:flutter_application_1/m10/camera_screen.dart';
import 'package:flutter_application_1/m10/contact_screen.dart';
import 'package:flutter_application_1/m10/location_screen.dart';
import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart';

class Home10 extends StatefulWidget {
  const Home10({super.key});

  @override
  State<Home10> createState() => _Home10State();
}

class _Home10State extends State<Home10> {
  void contact() async {
    print('contact');
    if (await Permission.contacts.status.isGranted) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const ContactScreen()));
    } else {
      var status = await Permission.contacts.request();
      print(status);
      if (status == PermissionStatus.granted) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ContactScreen()));
      } else if (status == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    }
  }

  void camera() async {
    print('camera');
    if (await Permission.camera.status.isGranted) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const CameraScreen()));
    } else {
      var status = await Permission.camera.request();
      print(status);
      if (status == PermissionStatus.granted) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CameraScreen()));
      } else if (status == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    }
  }

  void setupLocation() async {
    var loc = location.Location();

    if (!await loc.serviceEnabled()) {
      if (!await loc.requestService()) {
        return;
      }
    }

    var permission = await loc.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await loc.requestPermission();
      if (permission != PermissionStatus.granted) {
        return;
      }
    }

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LocationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: contact, child: const Text('Contact')),
            ElevatedButton(onPressed: camera, child: const Text('Camera')),
            ElevatedButton(
                onPressed: setupLocation, child: const Text('Location')),
          ],
        ),
      ),
    );
  }
}
