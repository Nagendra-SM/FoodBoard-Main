import 'package:foodboard_application/utils/colors.dart';
import 'package:foodboard_application/widgets/button_widget.dart';
import 'package:foodboard_application/widgets/textField_widget.dart';
import 'package:foodboard_application/widgets/big_text.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class User_Reset_Pass extends StatefulWidget {
  const User_Reset_Pass({Key? key}) : super(key: key);

  @override
  State<User_Reset_Pass> createState() => _User_Reset_PassState();
}

// ignore: camel_case_types
class _User_Reset_PassState extends State<User_Reset_Pass> {
  bool isChecked = false;
  // ignore: non_constant_identifier_names
  final TextEditingController new_pass = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController c_pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return AppColors.mainColor;
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
          leading: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.mainColor,
              )),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: BigText(
              text: "Reset Password", size: 20, fontWeight: FontWeight.bold)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 80),
                child: Container(
                  height: 480,
                  width: 310,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 181, 180, 180)
                            .withOpacity(0.4), //shadow color
                        blurRadius: 7, // shadow blur radius
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      ),
                    ],
                    color: const Color.fromARGB(255, 246, 244, 244),
                    border: Border.all(color: AppColors.lightGreyColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: BigText(
                            text: "Create New Password",
                            size: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Field_Widget(
                        type: TextInputType.emailAddress,
                        control: new_pass,
                        hint: "Password",
                        valid: (value) => null,
                        size: 15,
                        text: 'New Password *',
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Field_Widget(
                        type: TextInputType.visiblePassword,
                        control: c_pass,
                        hint: "Password",
                        valid: (value) => null,
                        size: 15,
                        text: 'Confirm New Password *',
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 25),
                            child: Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          BigText(
                              text: "Remember me",
                              color: Colors.black87,
                              size: 15,
                              fontWeight: FontWeight.bold)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Button_Widget(text: "Save", btn_width: 300, pressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
