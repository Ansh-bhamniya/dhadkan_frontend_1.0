import 'package:dhadkan_front/features/auth/LandingScreen.dart';
import 'package:dhadkan_front/features/common/TopBar.dart';
import 'package:dhadkan_front/features/patient/home/Heading.dart';
import 'package:dhadkan_front/features/patient/home/History.dart';
import 'package:dhadkan_front/features/patient/home/PatientButtons.dart';
import 'package:dhadkan_front/features/patient/home/PatientGraph.dart';
import 'package:dhadkan_front/utils/device/device_utility.dart';
import 'package:dhadkan_front/utils/storage/secure_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/http/http_client.dart';
import '../../../utils/theme/text_theme.dart';

class PatientHome extends StatefulWidget {
  
  const PatientHome({super.key});

  @override
  _PatientHomeState createState() => _PatientHomeState();
} 

  Future<void> _logout(BuildContext context) async {
    // Set the 'isLoggedin' value to false in secure storage
     await SecureStorageService.deleteData('authToken');
    
    // Optionally, clear all stored data
    // await _storage.deleteAll();

    // Navigate to the LandingScreen and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LandingScreen()),
      (Route<dynamic> route) => false,
    );
  }



  class _PatientHomeState extends State<PatientHome> {
    String _token = "";
    
    List<dynamic> history = [];
    Map<String, dynamic> graphData = {
      'times': [],
      'sbp': [],
      'dbp': [],
      'weight': []
    };



  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    // Check if the token is saved
    String? token = await SecureStorageService.getData('authToken');
    
    if (token == null || token.isEmpty) {
      // Token is not saved or is empty, navigate to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LandingScreen()),
      );
    } else {
      setState(() {
        _token = token;
      });
      _fetchData();
    }
  }
  
  _fetchData() async {
    try {
      Map<String, dynamic> response = await MyHttpHelper.private_post(
          '/patient/get-daily-data', {}, _token);

      if (response['success'] == 'true') {
        setState(() {
          history = response['data']['history'];
          graphData = response['data']['graphData'];
          print(graphData);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error in loading data")));
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MyDeviceUtils.getScreenWidth(context);
    var paddingWidth = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(title: TopBar(title: "Patient Home"),
              actions: [
          IconButton(
            onPressed: () {
              _logout(context);  // Calling the _logout method
            },
            icon: Icon(Icons.logout),
          ),
        ],),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingWidth),
        child: 
         SingleChildScrollView(
          
            child: Column(
              children: [
                SizedBox(height: 15),
                Heading(),
                SizedBox(height: 15),
                PatientGraph(graphData: graphData),
                SizedBox(height: 20),
                PatientButtons(),
                SizedBox(height: 20),
                Text(
                  "History",
                  style: MyTextTheme.textTheme.headlineLarge,
                ),
                SizedBox(height: 50),
                History(history: history),
                SizedBox(height: 100)
              ],
            ),
          
        ),
      ),
    );
  }
}


