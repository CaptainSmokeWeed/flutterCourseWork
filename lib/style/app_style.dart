import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle{
  //Colors
 static Color bgColor = Color(0xFF000633);
 static Color mainColor = Color(0xFF031994);
 static Color accentColor = Color(0xFF0065FF);

 static List<Color> cardsColor = [
  Colors.green.shade200,
  Colors.amber.shade200,
  Colors.redAccent.shade200,
  Colors.amber.shade100,
  Colors.amber.shade400,
  Colors.amber.shade800,
  Colors.amber.shade500,
 ];

 static List<Color> linesColor = [Colors.green, Colors.white, Colors.amber, Colors.redAccent];

 //Text Style
 static TextStyle mainTitle =
  GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold);
 static TextStyle mainContent =
 GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.normal);
 static TextStyle dateTitle =
 GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w500);
}

TextStyle get subHeadingStyle{
 return GoogleFonts.lato(
  textStyle: const TextStyle(
   fontSize: 24,
   fontWeight: FontWeight.bold,
   color: Colors.grey
  )
 );
}
TextStyle get titleStyle{
 return GoogleFonts.lato(
     textStyle: const TextStyle(
     fontSize: 16,
     fontWeight: FontWeight.bold,
     color: Colors.black
   )
 );
}
TextStyle get subTitleStyle{
 return GoogleFonts.lato(
     textStyle: const TextStyle(
         fontSize: 14,
         fontWeight: FontWeight.bold,
         color: Colors.grey
     )
 );
}

TextStyle get headingStyle{
 return GoogleFonts.lato(
     textStyle: const TextStyle(
         fontSize: 30,
         fontWeight: FontWeight.bold

     )
 );
}
