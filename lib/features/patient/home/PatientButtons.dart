import 'package:dhadkan_front/features/patient/home/PatientButton.dart';
import 'package:dhadkan_front/utils/device/device_utility.dart';
import 'package:dhadkan_front/utils/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientButtons extends StatelessWidget {
  const PatientButtons({super.key});

  @override
  Widget build(BuildContext context) {

    void handleAddButtonPress(){
      Navigator.pushNamed(context, 'patient/add/');
    }

    void handleTestsButtonPress(){
      Navigator.pushNamed(context, 'patient/tests/');
    }
    var screenWidth = MyDeviceUtils.getScreenWidth(context);
    var width = screenWidth * 0.9;
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PatientButton(title: "Add Data", handleClick: handleAddButtonPress),
          SizedBox(width: 20,),
          PatientButton(title: "Tests", handleClick: handleTestsButtonPress),
          SizedBox(width: 20,),
          PatientButton(title: "Medication", handleClick: handleAddButtonPress),
        ],
      ),
    );
  }
}
