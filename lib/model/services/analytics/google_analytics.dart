import 'package:firebase_analytics/firebase_analytics.dart';

class GoogleAnalytics {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> sendLogEvent(String name) async {
    try {
      await analytics.logEvent(
        name: name,
        parameters: <String, dynamic>{
          'page': 'home',
          'button_id': 'example_button',
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future sendLoginEvent(String loginMethod) async {
    await analytics.logLogin(loginMethod: loginMethod);
  }

  Future purchaseEventGoogle(total) async {
    analytics.logPurchase(
        currency: 'USD', value: total, shipping: 10.2, coupon: 'test_coupon');
  }
}
