import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static Color color1 = const Color(0xFF0B8FAC);
  static Color color2 = const Color(0xff7CDDC4);
  static Color black = const Color(0xFF35364F);
  static Color scaffoldBG = const Color(0xFFE6EFF9);
  static Color white = const Color(0xFFFFFFFF);
  static Color redColor = const Color(0xFFE85050);
}

TextStyle getTitleStyle(
        {Color color = const Color(0xFF0B8FAC),
        double? fontSize = 18,
        FontWeight? fontWeight = FontWeight.bold}) =>
    TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: GoogleFonts.cairo().fontFamily,
    );

TextStyle getbodyStyle(
        {Color color = const Color(0xFF35364F),
        double? fontSize = 14,
        FontWeight? fontWeight = FontWeight.w400}) =>
    TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: GoogleFonts.cairo().fontFamily,
    );

TextStyle getsmallStyle(
        {Color color = const Color(0xFF35364F),
        double? fontSize = 12,
        FontWeight? fontWeight = FontWeight.w500}) =>
    TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: GoogleFonts.cairo().fontFamily,
    );
