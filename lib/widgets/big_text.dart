// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  final int maxLines;
  double size;
  FontWeight fontWeight;
  TextOverflow overflow;
  BigText(
      {Key? key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.size = 0,
      this.fontWeight = FontWeight.w700,
      this.maxLines = 1,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
          fontFamily: "Roboto",
          color: color,
          fontWeight: fontWeight,
          fontSize: size == 0 ? 20 : size),
    );
  }
}
