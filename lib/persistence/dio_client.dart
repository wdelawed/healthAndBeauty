import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/model/networkResponse.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class DioClient {
  Dio _dio ;
  DioClient(){
    if( _dio == null)
      _dio = Dio(BaseOptions(baseUrl: Utils.baseUrl));
  }

  Future<NetworkResponse<Prescription>> addPrescription(Prescription prescription) async{
      final mimeTypeData = lookupMimeType(prescription.presc_image, headerBytes: [0xFF, 0xD8]).split('/');
      dynamic _value = "" ;
      if(prescription.presc_image != null && prescription.presc_image.isNotEmpty )
          _value = await MultipartFile.fromFile(prescription.presc_image, contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

      Map<String, dynamic> data = prescription.toJson();
      data.update("presc_image", (value) => value !=null && value.isNotEmpty? _value: value);
      FormData formData = FormData.fromMap(
        data
      );

      final _result = await _dio.request<Map<String, dynamic>>('/prescription/',
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            baseUrl: Utils.baseUrl),
        data: formData);
    final value = NetworkResponse<Prescription>.fromJson(
      _result.data,
      (json) => Prescription.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  
}


      

      