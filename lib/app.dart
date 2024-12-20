import 'package:dhadkan_front/features/auth/LandingScreen.dart';
import 'package:dhadkan_front/features/auth/Splash_Screen.dart';
import 'package:dhadkan_front/features/doctor/home/DoctorHome.dart';
import 'package:dhadkan_front/features/doctor/patientList/PatientList.dart';
import 'package:dhadkan_front/features/patient/addData/AddDataScreen.dart';
import 'package:dhadkan_front/features/patient/home/PatientHomeScreen.dart';
import 'package:dhadkan_front/features/patient/tests/TestsScreen.dart';
import 'package:dhadkan_front/utils/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dhadkan',
      themeMode: ThemeMode.light,
      theme: MyTheme.myTheme,
      darkTheme: MyTheme.myTheme,
      initialRoute: '/',
      routes: {

      '/': (context) => SplashScreen(),          // Default route
      'landing': (context) => LandingScreen(),   // Landing/login screen
      'patient/home/': (context) => PatientHome(), 
      'patient/add/': (context) => AddData(),
      'patient/tests/': (context) => TestsScreen(),
      'doctor/home/': (context) => DoctorHome(),
      'doctor/all-patients': (context) => PatientList(),
        // '/': (context) => LandingScreen(),
        // 'patient/home/': (context) => PatientHome(),
        // 'patient/add/': (context) => AddData(),
        // 'patient/tests/': (context) => TestsScreen(),
        // 'doctor/home/': (context) => DoctorHome(),
        // 'doctor/all-patients': (context) => PatientList(),
      },
    );
  }
}
