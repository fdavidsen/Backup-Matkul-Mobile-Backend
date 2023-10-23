import 'package:firebase_analytics/firebase_analytics.dart';

class MyAnalyticsHelper {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> testEventLog(_value) async {
    await analytics
        .logEvent(name: '${_value}_click', parameters: {'Value': _value});
    print('Send Event');
  }

  Future<void> testSetUserId(_value) async {
    await analytics.setUserId(id: '$_value');
    print('setUserId succeeded');
  }

  Future<void> testSetUserProperty() async {
    await analytics.setUserProperty(name: 'regular', value: 'indeed');
    print('setUserProperty succeeded');
  }
}
