import 'package:flutter/material.dart';
import 'package:foodboard_application/utils/colors.dart';

// ignore: camel_case_types
class Button_Widget extends StatelessWidget {
  final String text;
  // ignore: non_constant_identifier_names
  final double btn_width;
  final Function()? pressed;
  const Button_Widget(
      {Key? key,
      required this.text,
      // ignore: non_constant_identifier_names
      required this.btn_width,
      required this.pressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 82, 224, 82),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: btn_width,
        onPressed: pressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: "Roboto"),
        ),
      ),
    );
  }
}
