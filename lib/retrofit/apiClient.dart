import 'dart:ui';

import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/model/networkResponse.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:flutter/cupertino.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'apiClient.g.dart';

@RestApi(baseUrl: "http://192.168.44.103:8000/api/")
abstract class ApiClient {
factory ApiClient(Dio dio, {String baseUrl}){
dio.options = BaseOptions( connectTimeout: 5000);
return _ApiClient(dio, baseUrl: "http://192.168.44.103:8000/api/");}

@GET('/customer/')
Future<NetworkResponse<List<Customer>>> getCustomers() ; 

@GET('/prescription/')
Future<NetworkResponse<List<Prescription>>> getPrescriptions() ; 

@GET('/customer/{id}')
Future<NetworkResponse<Customer>> getCustomer(@Path("id") int id);

@GET("/customer/{id}/edit")
Future<NetworkResponse<Customer>> editCustomer(@Body() Customer customer, @Path() int id);

@POST("/customer/")
Future<NetworkResponse<Customer>>postCustomer(@Body() Customer customer) ;

@DELETE("/customer/{id}")
Future<NetworkResponse<Customer>> deleteCustomer(@Path() int id) ;

@POST("/customer/updateImage")
@MultiPart()
Future<NetworkResponse<Dummy>> updateCustomerAfterImage(@Part(name: "after_img", contentType: "") String image_file, @Field() int id) ;

}
class Dummy {
  Dummy();
  factory Dummy.fromJson(Map<String, dynamic> json){
    return null ;
  }

  Map<String, dynamic> toJson(){
    return null ;
  }
  String toString(){
    return "null" ;
  }
}