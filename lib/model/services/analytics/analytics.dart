import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

class Analytics {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> sendLogEvent(String name) async {
    try {
      print('log $name');
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
    print('loginEvent');
    await analytics.logLogin(loginMethod: loginMethod);
  }

  Future purchaseEventGoogle()async{
    print('analyticsPurchase');
    analytics.logPurchase(
      currency: 'USD',
      value: 1.5,
      shipping: 10.2,
      coupon: 'test_coupon'

    );
  }

  void createPurchaseEvent() {
    try {
      BranchUniversalObject buo = BranchUniversalObject(
        canonicalIdentifier: 'item/123',
        title: 'Item 123',
        contentDescription: 'Description for Item 123',
        imageUrl: 'https://example.com/item123.png',
      );
      BranchEvent event = BranchEvent.customEvent('Purchase');
      event.currency = BranchCurrencyType.USD;
      event.revenue = 1.5;
      event.shipping = 10.2;
      event.tax = 12.3;
      event.coupon = "test_coupon";
      // event.affiliation = "test_affiliation";
      // event.eventDescription = "Event_description";
      // event.searchQuery = "item 123";
      event.addCustomData(
          'Custom_Event_Property_Key1', 'Custom_Event_Property_val1');

      FlutterBranchSdk.trackContent(buo: [buo], branchEvent: event);
    } catch (e) {
      print(e);
    }
  }
}
