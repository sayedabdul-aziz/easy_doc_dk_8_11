import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static Color primaryColor = const Color(0xFF255ED6);
  static Color containerColor = Colors.blue[50]!;
  static Color textColor = const Color(0xFF35364F);
  static Color scaffoldBG = const Color(0xFFE6EFF9);
  static Color white = const Color(0xFFFFFFFF);
  static Color redColor = const Color(0xFFE85050);
}

TextStyle getTitleStyle(
        {Color color = const Color(0xFF255ED6),
        double? fontSize = 18,
        FontWeight? fontWeight = FontWeight.bold}) =>
    TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    );

TextStyle getbodyStyle(
        {Color color = const Color(0xFF35364F),
        double? fontSize = 16,
        FontWeight? fontWeight = FontWeight.w400}) =>
    TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    );

TextStyle getsmallStyle(
        {Color color = const Color(0xFF35364F),
        double? fontSize = 14,
        FontWeight? fontWeight = FontWeight.w500}) =>
    TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    );
