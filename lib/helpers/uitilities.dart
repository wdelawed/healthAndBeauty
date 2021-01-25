import 'dart:io';

import 'package:dio/dio.dart';

class Utils {
  static String imagesUrl = "http://192.168.44.103:8000/images/";

  static String baseUrl   = "http://192.168.44.103:8000/api" ;

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

  static String toServerDate(String da) {
    dynamic date = da.split(" AT ")[0].split("-") ;
    dynamic time = da.split(" AT ")[1] ;

    String y = date[2] ;
    String m = date[1] ;
    String d = date[0] ;
    return "$y-$m-$d $time" ;

  }
}