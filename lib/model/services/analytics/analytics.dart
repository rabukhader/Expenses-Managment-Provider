import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> sendLogEvent(String name) async {
    await analytics.logEvent(
      name: name,
      parameters: <String, dynamic>{
        'page': 'home',
        'button_id': 'example_button',
      },
    );
  }

  Future sendLoginEvent(String loginMethod)async {
    await analytics.logLogin(
      loginMethod: loginMethod
    );
  }
}
