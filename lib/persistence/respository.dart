import 'dart:convert';
import 'dart:io';

import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/model/networkResponse.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:HealthAndBeauty/retrofit/apiClient.dart';
import 'package:dio/dio.dart';

class Repository{
  ApiClient _apiClient = ApiClient(Dio()) ; 
  
  Future<NetworkResponse<Customer>> getCustomer(int id ) async {
    try {
        NetworkResponse<Customer> response = await _apiClient.getCustomer(id) ;
        return response ;
    } 
    catch(e){
      return NetworkResponse<Customer>(data: null, error: true, msg: e.message) ;
    }
  }

  Future<List<Customer>> getAllCustomers() async {
    NetworkResponse<List<Customer>> response = await _apiClient.getCustomers() ;
    return response.data ;
  }

    Future<List<Prescription>> getAllPrescriptions() async {
    NetworkResponse<List<Prescription>> response = await _apiClient.getPrescriptions() ;
    return response.data ;
  }

  Future<bool> editCustomer(Customer newCustomer, int id) async {
    NetworkResponse<Customer> response = await _apiClient.editCustomer(newCustomer, id);
    return handle(response) as bool ;

  }



  Future<bool> deleteCustomer(int id) async{
    NetworkResponse<Customer> response = await _apiClient.deleteCustomer(id) ;
    return handle(response) as bool ;
  }

  Future<bool> updateCustomerImage(File image, int id) async {
    String file = await base64.encode(image.readAsBytesSync());
    NetworkResponse<Dummy> response = await _apiClient.updateCustomerAfterImage(file, id);
    return handle(response) as bool; 
  }

    Future<dynamic> handle(NetworkResponse<dynamic> response){
    if(! response.error && response.data != null)
    {
      return response.data;
    }
    else if (!response.error && response.data == null){
      return Future<bool>.value(true) ;
    }
    else {
      throw Exception(response.msg) ;
    }
  }

  Future<bool> addCustomer(Customer customer) async {
    NetworkResponse<Customer> response = await _apiClient.postCustomer(customer) ;
    return handle(response) as bool ;
  }
}

