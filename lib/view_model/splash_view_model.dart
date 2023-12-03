import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_links/uni_links.dart' as unilink;

class SplashViewModel with ChangeNotifier {
  final auth = FirebaseAuth.instance;

  Future<void> checkDeepLink() async {
    final res = await unilink.getInitialLink();
    if (res != null) {
      handleDeepLink(res);
    }

    unilink.linkStream.listen((String? link) {
      if (link != null) {
        handleDeepLink(link);
      }
    });
  }

  void handleDeepLink(String link) {
    print('Received deep link: $link');
  }

  Future<void> initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    handleLinkData(data);

    FirebaseDynamicLinks.instance.onLink.listen(
      (PendingDynamicLinkData? dynamicLink) async {
        handleLinkData(dynamicLink);
      },
    );
  }

  void handleLinkData(PendingDynamicLinkData? data) {
    if (data == null) {
      return;
    }

    final Uri deepLink = data.link;
    print(deepLink);
  }

  Future<User?> getCurrentUser() async {
    try {
      final User? user = auth.currentUser;
      return user;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  void init(context) async {
    GeolocatorPlatform.instance;
    await checkDeepLink();
    await initDynamicLinks();
    try {
      User? user = await getCurrentUser();
      if (user != null) {
        _navigateTo(context, '/home');
      } else {
        _navigateTo(context, '/');
      }
      ;
    } catch (e) {
      _navigateTo(context, '/error');
    }
  }

  void _navigateTo(BuildContext context, String route) {
    GoRouter.of(context).go(route);
  }
}