import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color bgcolor = Color(0xFFedf0f8);
  static Color primarycolor = Color(0xFF1e283e);
  static TextStyle mainTitleStyle = GoogleFonts.nunito(
      color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16.0);
  static TextStyle TitleStyle = GoogleFonts.nunito(
      color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16.0);
  static TextStyle helloTitleStyle = GoogleFonts.nunito(
    color: Color.fromARGB(255, 39, 204, 45),
    fontWeight: FontWeight.w800,
    fontSize: 24.0,
  );
  static TextStyle questionTitleStyle = GoogleFonts.nunito(
    color: Color.fromARGB(255, 86, 86, 86),
    fontWeight: FontWeight.w800,
    fontSize: 20.0,
  );
  static TextStyle subTitleStyle = GoogleFonts.nunito(
      color: Color(0xFF0808080), fontWeight: FontWeight.w400, fontSize: 16.0);
  static TextStyle PriceTitleStyle = GoogleFonts.nunito(
      color: primarycolor, fontWeight: FontWeight.bold, fontSize: 32.0);
}
