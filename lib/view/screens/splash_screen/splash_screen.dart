import 'package:camera/camera.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../view_model/login_register_view_model.dart';
import 'package:uni_links/uni_links.dart' as unilink;

late List<CameraDescription> cameras;

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

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var mainGradient = LinearGradient(
      colors: [Theme.of(context).primaryColor, Theme.of(context).hintColor],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient),
        alignment: Alignment.center,
        child: Image.asset(
          "assets/user.png",
          width: 200,
          height: 200,
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future.delayed(const Duration(milliseconds: 200), () {
      checkCurrentUserAndNavigate(context);
    });
  }

  void checkCurrentUserAndNavigate(BuildContext context) async {
    cameras = await availableCameras();
    GeolocatorPlatform.instance;
    await checkDeepLink();
    await initDynamicLinks();
    final loginRegisterViewModel =
        Provider.of<LoginRegisterViewModel>(context, listen: false);

    loginRegisterViewModel.getCurrentUser().then((user) {
      if (user != null) {
        _navigateTo(context, '/home');
      } else {
        _navigateTo(context, '/');
      }
    }).catchError((error) {
      _navigateToError(context, error);
    });
  }

  void _navigateTo(BuildContext context, String route) {
    GoRouter.of(context).go(route);
  }

  void _navigateToError(BuildContext context, dynamic error) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MaterialApp(
          home: Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('Error: $error')),
          ),
        ),
      ),
    );
  }
}
