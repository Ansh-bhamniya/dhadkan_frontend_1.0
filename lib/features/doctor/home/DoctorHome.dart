import 'package:dhadkan_front/features/common/TopBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/device/device_utility.dart';
import 'DoctorButtons.dart';
import 'DoctorHead.dart';
import 'DoctorHistogram.dart';
import 'DoctorPie.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MyDeviceUtils.getScreenWidth(context);
    var paddingWidth = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(title: TopBar(title: "Welcome, Doctor")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingWidth),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              DoctorHead(),
              SizedBox(height: 15),
              DoctorButtons(),
              SizedBox(height: 15),
              DoctorHistogram(),
              SizedBox(height: 15),
              DoctorPie(),
              SizedBox(height: 15)
            ],
          ),
        ),
      ),
    );
  }
}
