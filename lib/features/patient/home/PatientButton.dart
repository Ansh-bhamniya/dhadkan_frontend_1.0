import 'package:dhadkan_front/utils/constants/colors.dart';
import 'package:dhadkan_front/utils/device/device_utility.dart';
import 'package:dhadkan_front/utils/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientButton extends StatelessWidget {
  final String title;
  final void Function() handleClick;

  const PatientButton(
      {super.key, required this.title, required this.handleClick});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MyDeviceUtils.getScreenWidth(context);
    var buttonWidth = screenWidth * 0.25;
    return Container(
      width: buttonWidth,
      child: ElevatedButton(
          onPressed: handleClick,
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.black,
            backgroundColor: MyColors.primary,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 12), // Padding
          ),
          child: Text(
            title,
            style: MyTextTheme.textTheme.titleMedium,
          )),
    );
  }
}
