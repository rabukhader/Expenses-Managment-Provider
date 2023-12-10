import 'package:expenses_managment_app_provider/model/services/analytics/branch_analytics.dart';
import 'package:expenses_managment_app_provider/model/services/analytics/google_analytics.dart';

class AllAnalytics {
  BranchAnalytics branchAnalytics = BranchAnalytics();
  GoogleAnalytics googleAnalytics = GoogleAnalytics();

  Future purchaseAnalytics(total) async {
    await googleAnalytics.purchaseEventGoogle(total);
    branchAnalytics.branchPurchaseEvent(total);
  }

  Future loginAnalytics(loginMethod) async {
    await googleAnalytics.sendLoginEvent(loginMethod);
    branchAnalytics.branchLoginEvent(loginMethod);
  }
}
