import 'package:flutter/material.dart';
import 'package:flutter_application_1/my-analytics-helper.dart';

class Home6 extends StatefulWidget {
  const Home6({super.key});

  @override
  State<Home6> createState() => _Home6State();
}

class _Home6State extends State<Home6> {
  MyAnalyticsHelper fbAnalytics = MyAnalyticsHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Working with Analytics'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  fbAnalytics.testSetUserId("agung");
                },
                child: Text('Send Event'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  fbAnalytics.testSetUserProperty();
                },
                child: Text('Send Property'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  fbAnalytics.testEventLog("send_error");
                },
                child: Text('Send Error'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
