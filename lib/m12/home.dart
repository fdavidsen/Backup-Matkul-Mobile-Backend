import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

class Home12 extends StatefulWidget {
  const Home12({super.key});

  @override
  State<Home12> createState() => _Home12State();
}

void backgroundCompute(args) {
  print('background compute callback');
  print('calculating fibonacci from a background process');

  int first = 0;
  int second = 1;
  for (var i = 2; i <= 50; i++) {
    var temp = second;
    second = first + second;
    first = temp;
    sleep(Duration(microseconds: 200));
    print('first: $first, second: $second.');
  }
  print('finished calculating fibo');
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  return true;
}

void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  int sum = 60;
  Timer.periodic(Duration(seconds: 1), (timer) async {
    sum--;

    if (sum < 0) {
      final service = FlutterBackgroundService();
      service.invoke('stopService');
    }

    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        flutterLocalNotificationsPlugin.show(
            880,
            'Countdown Service',
            'Remain $sum times ...',
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'foreground',
                'Foreground Service',
                icon: 'ic_bg_service_small',
                ongoing: true,
              ),
            ));
      }
    }

    print('Background Service: $sum');

    service.invoke('update', {'count': sum});
  });
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    iosConfiguration: IosConfiguration(
        autoStart: false, onForeground: onStart, onBackground: onIosBackground),
    androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: false,
        notificationChannelId: 'foreground',
        initialNotificationTitle: 'Foreground Service',
        initialNotificationContent: 'Initializing',
        foregroundServiceNotificationId: 880),
  );
  service.startService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'foreground',
    'Foreground Service',
    description: 'This channel is used for important notifications.',
    importance: Importance.low,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

class _Home12State extends State<Home12> {
  @override
  Widget build(BuildContext context) {
    String text = 'Stop Service';

    return Scaffold(
      appBar: AppBar(
        title: Text('Countdown Service'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: FlutterBackgroundService().on('update'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text(
                      '60 s',
                      style: TextStyle(fontSize: 40),
                    );
                  }
                  final data = snapshot.data!;
                  String? count = data['count'].toString() + ' s';
                  return Text(
                    count,
                    style: TextStyle(fontSize: 40),
                  );
                }),
            ElevatedButton(
                onPressed: () async {
                  final service = FlutterBackgroundService();
                  var isRunning = await service.isRunning();

                  if (isRunning) {
                    service.invoke('stopService');
                    text = 'Restart Service';
                  } else {
                    service.startService();
                    text = 'Stop Service';
                  }
                  setState(() {});
                },
                child: Text(text))
          ],
        ),
      ),
    );

    // return Scaffold(
    //   body: Center(
    //     child: ElevatedButton(
    //         onPressed: () {
    //           compute(backgroundCompute, null);
    //         },
    //         child: Text('Calculate fibo on compute isolate')),
    //   ),
    // );
  }
}
