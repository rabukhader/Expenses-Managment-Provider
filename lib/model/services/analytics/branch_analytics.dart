import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

class BranchAnalytics {
  void branchLoginEvent(loginMethod) {
    try {
      BranchUniversalObject buo = BranchUniversalObject(
        canonicalIdentifier: 'item/123',
        title: 'Item 123',
        contentDescription: 'Description for Item 123',
        imageUrl: 'https://example.com/item123.png',
      );
      BranchEvent event = BranchEvent.standardEvent(BranchStandardEvent.LOGIN);
      event.currency = BranchCurrencyType.USD;
      event.addCustomData('login_method', loginMethod);

      FlutterBranchSdk.trackContent(buo: [buo], branchEvent: event);
    } catch (e) {
      print(e);
    }
  }

  void branchPurchaseEvent(total) {
    try {
      BranchUniversalObject buo = BranchUniversalObject(
        canonicalIdentifier: 'item/123',
        title: 'Item 123',
        contentDescription: 'Description for Item 123',
        imageUrl: 'https://example.com/item123.png',
      );
      BranchEvent event =
          BranchEvent.standardEvent(BranchStandardEvent.PURCHASE);
      event.currency = BranchCurrencyType.USD;
      event.revenue = total;
      event.shipping = 10.2;
      event.tax = 12.3;
      event.coupon = "test_coupon";
      event.addCustomData(
          'Custom_Event_Property_Key1', 'Custom_Event_Property_val1');

      FlutterBranchSdk.trackContent(buo: [buo], branchEvent: event);
    } catch (e) {
      print(e);
    }
  }
}
