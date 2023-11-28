import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> sendAnalyticsEvent() async {
    await analytics.logEvent(
      name: 'button_click',
      parameters: <String, dynamic>{
        'page': 'home',
        'button_id': 'example_button',
      },
    );
    await analytics.logLogin(loginMethod: 'Email Password');
  }
}
