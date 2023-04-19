// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:foodboard_application/utils/colors.dart';
import 'package:foodboard_application/widgets/app_icon.dart';
import 'package:foodboard_application/widgets/big_text.dart';

// ignore: camel_case_types, must_be_immutable
class Forgot_Container_Widget extends StatelessWidget {
  final IconData icon;
  final String via_text;
  final String type;

  double size;
  Forgot_Container_Widget(
      {Key? key,
      required this.icon,
      this.size = 35,
      required this.type,
      required this.via_text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25),
      height: 120,
      width: 300,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4), //shadow color
            blurRadius: 7, // shadow blur radius
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
        color: Colors.white,
        border: Border.all(color: AppColors.backgroundColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          AppIcon(
            icon: icon,
            size: 35,
            iconColor: AppColors.mainColor,
            backgroundColor: AppColors.backgroundColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.only(top: 30, left: 10),
            child: Column(
              children: <Widget>[
                BigText(
                  text: via_text,
                  color: Colors.grey,
                  size: 15,
                ),
                const SizedBox(
                  height: 10,
                ),
                BigText(
                  text: type,
                  size: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
