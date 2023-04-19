import 'package:foodboard_application/utils/colors.dart';
import 'package:foodboard_application/widgets/button_widget.dart';
import 'package:foodboard_application/widgets/forgot_container.dart';
import 'package:foodboard_application/widgets/big_text.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class User_Forgot_Pass extends StatefulWidget {
  const User_Forgot_Pass({Key? key}) : super(key: key);

  @override
  State<User_Forgot_Pass> createState() => _User_Forgot_PassState();
}

// ignore: camel_case_types
class _User_Forgot_PassState extends State<User_Forgot_Pass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.mainColor,
            ),
            onPressed: () {},
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: BigText(
            size: 20,
            text: "Forgot Password ?",
            fontWeight: FontWeight.bold,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: BigText(
                      text:
                          "Select which contact details should we use to reset your password",
                      size: 15,
                      maxLines: 2,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 60,
                ),
                Forgot_Container_Widget(
                    icon: Icons.message,
                    type: "942****223",
                    via_text: "via SMS :    "),
                const SizedBox(
                  height: 30,
                ),
                Forgot_Container_Widget(
                    icon: Icons.email,
                    type: "mi******@gmail.com",
                    via_text: "via Email :                   "),
                const SizedBox(
                  height: 150,
                ),
                Button_Widget(text: "Next", btn_width: 320, pressed: () {})
              ],
            ),
          ),
        ));
  }
}
