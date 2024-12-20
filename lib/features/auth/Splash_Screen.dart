import 'dart:async';

import 'package:dhadkan_front/features/auth/LandingScreen.dart';
import 'package:dhadkan_front/features/patient/home/PatientHomeScreen.dart';
import 'package:dhadkan_front/utils/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:dhadkan_front/utils/storage/secure_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    _checkLoginStatus();
  }


  // Function to check if the user is already logged in
  void _checkLoginStatus() async {
    String? token = await SecureStorageService.getData('authToken');

    if (token != null) {
      // Validate the token with the backend
      bool isValid = await _validateToken(token);

      // Delay to show the splash screen for a few seconds

      Timer(Duration(seconds: 2), () async {
        if (isValid) {
          print("HERE1");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PatientHome()),
          );
        } else {
          print("HERE0");
          print(isValid);
          print("***");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LandingScreen()),
          );
        }
      });
    } else {
                print("HERE3");

      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LandingScreen()),
        );
      });
    }
  }


  // Function to validate token with the backend
Future<bool> _validateToken(String token) async {
  try {
    // Use MyHttpHelper.get method instead of router.get
    final response = await MyHttpHelper.private_get(
      '/patient/validate-token',
      token
    );

    // You should check for a status code or a specific response field
    if (response['status'] == 'valid') { // Example response check
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Error validating token: $e');
    return false;
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/Images/logo.png'),
      ),
    );
  }
}