// ignore: duplicate_ignore

// ignore_for_file: file_names, duplicate_ignore, must_be_immutable

// ignore: file_names
import 'package:flutter/material.dart';
import 'package:foodboard_application/utils/colors.dart';

import 'package:foodboard_application/widgets/big_text.dart';

// ignore: camel_case_types
class Field_Widget extends StatelessWidget {
  final TextInputType type;
  final TextEditingController control;
  final String hint;
  final String text;
  final Color color;
  final double size;
  FontWeight weight;

  final String? Function(String?)? valid;
  Field_Widget({
    Key? key,
    required this.type,
    required this.control,
    required this.hint,
    required this.valid,
    this.color = const Color(0xFF000000),
    required this.size,
    required this.text,
    this.weight = FontWeight.w700,
    required FontWeight fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.bottomLeft,
              child: BigText(
                  text: text, color: color, size: size, fontWeight: weight)),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4), //shadow color
                  blurRadius: 7, // shadow blur radius
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextFormField(
              controller: control,
              validator: valid,
              autofocus: false,
              keyboardType: type,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.fromLTRB(25, 15, 20, 15),
                filled: true,
                fillColor: Colors.white,

                hintText: hint,
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.lightGreyColor)),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.lightGreyColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
