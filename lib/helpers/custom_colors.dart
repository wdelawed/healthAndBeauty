import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UiColors {
  static const Color main = Color(0xff5B139A) ;
  static const Color textMain = Color(0xff464646) ;
  static const Color navIconsFill = Color(0xffB7B7B7) ;
  static const Color navIconsStroke = Color(0xffB7B7B7) ;
  static const Color navIconsSelected = Color(0xff6170FC) ;
  static const Color prescDetailsSubtitle = Color(0xffB7B7B7) ;
  static const Color prescDetailsParagraph = Color(0xff9B9B9B) ;
  static const LinearGradient btnsGradient = LinearGradient(colors: [Color(0xff6CBBF5 ), Color(0xff5B139A),],) ;

  static const TextStyle title = TextStyle(color: UiColors.textMain, fontSize: 20, fontWeight: FontWeight.w500) ;
  static const TextStyle subtitle = TextStyle(color: UiColors.textMain, fontSize: 14, fontWeight: FontWeight.w300) ;
}