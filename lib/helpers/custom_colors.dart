import 'dart:io';

import 'package:dio/dio.dart';
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

class Helper {
  static String parseError(dynamic e){
    if(e is DioError){
      DioError dio = e ;
      switch(dio.type){
        case DioErrorType.CONNECT_TIMEOUT : 
          return "connection timeout error" ; 
          break ;
        case DioErrorType.RECEIVE_TIMEOUT:
          return "receive timeout error" ;
          break;
        case DioErrorType.SEND_TIMEOUT:
          return "sending data timeout error" ;
          break ;
        case DioErrorType.RESPONSE: 
          return "error handling response" ;
          break ;
        case DioErrorType.CANCEL:
          return "request canceled error" ;
          break;
        default:
          return "unknown error: ${e.toString()}" ;
          break;
      }
    }
    if(e is SocketException) {
      return "socket error : ${e.toString()}" ;
    }
    else {
      return "Error : ${e.toString()}" ;
    }
  }
}