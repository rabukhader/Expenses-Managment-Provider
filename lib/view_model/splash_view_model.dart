import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashViewModel with ChangeNotifier {
  final supabaseAuth = Supabase.instance.client.auth;
  StreamSubscription<Map>? streamSubscription;
  StreamController<String> controllerData = StreamController<String>();

  Future<void> listenDynamicLinks() async {
    try {
      streamSubscription = FlutterBranchSdk.listSession().listen((data) async {
        controllerData.sink.add(data.toString());
        print('listening');
        if (data.containsKey('+clicked_branch_link') &&
            data['+clicked_branch_link'] == true) {
          print(
              '------------------------------------Link clicked----------------------------------------------');
          print('Custom id: ${data['id']}');
          print(
              '------------------------------------------------------------------------------------------------');
          String route = data['\$marketing_title'];
          if (route == 'details') {
            String id = data['id'];
            _navigateTo(
              '/details',
              id: id,
            );
          } else {
            _navigateTo('/$route');
          }
        } else if (data['+non_branch_link'] != null) {
          _navigateTo('/error');
        }
      }, onError: (error) {
        print('listSesseion error: ${error.toString()}');
      });
    } catch (e) {
      print('Listening Error : $e');
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final User? user = supabaseAuth.currentUser;
      return user;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  Future<void> init() async {
    try {
      GeolocatorPlatform.instance;
      await listenDynamicLinks();
      User? user = await getCurrentUser();
      if (user != null) {
        _navigateTo('/home');
      } else {
        _navigateTo('/');
      }
    } catch (e) {
      _navigateTo('/error');
    }
  }

  Future<void> _navigateTo(String route, {String? id}) async {
    try {
      if (id != null) {
        await Get.toNamed(route, arguments: id);
      } else {
        await Get.toNamed(route);
      }
    } catch (e) {
      print('Navigation Error: $e');
    }
  }
}
