
import 'package:HealthAndBeauty/model/component.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/model/networkResponse.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:HealthAndBeauty/persistence/dio_client.dart';
import 'package:HealthAndBeauty/retrofit/apiClient.dart';
import 'package:dio/dio.dart';

class Repository{
  ApiClient _apiClient = ApiClient(Dio()) ; 
  DioClient _dioClient = DioClient();
  
  Future<NetworkResponse<Customer>> getCustomer(int id ) async {
    try {
        NetworkResponse<Customer> response = await _apiClient.getCustomer(id) ;
        return response ;
    } 
    catch(e){
      return NetworkResponse<Customer>(data: null, error: true, msg: e.toString()) ;
    }
  }

  Future<List<Customer>> getAllCustomers() async {
    NetworkResponse<List<Customer>> response = await _apiClient.getCustomers() ;
    if(response.error)
      throw Exception(response.msg) ;
    return response.data ;
  }

    Future<List<Prescription>> getAllPrescriptions() async {
    NetworkResponse<List<Prescription>> response = await _apiClient.getPrescriptions() ;
    return response.data ;
  }


    Future<Prescription> addPrescription(Prescription prescription) async {
        NetworkResponse<Prescription> response = await _dioClient.addPrescription(prescription) ;
        if(response.error)
          throw Exception(response.msg) ;
        return response.data ;
    }

  Future<Customer> editCustomer(Customer newCustomer, int id) async {
    NetworkResponse<Customer> response = await _apiClient.editCustomer(newCustomer, id);
    if(response.error)
    throw(Exception(response.msg));
    return response.data;
  }



  Future<int> deleteCustomer(int id) async{
    NetworkResponse<int> response = await _apiClient.deleteCustomer(id) ;
    if(response.error)
    throw(Exception(response.msg));
    return response.data;
  }
  Future<Customer> addCustomer(Customer customer) async{
    NetworkResponse<Customer> response = await _dioClient.addCustomer(customer) ;
    if(response.error)
    throw(Exception(response.msg));
    return response.data;
  }

  Future<Customer> updateCustomerImage(String image, int id) async {
    NetworkResponse<Customer> response = await _dioClient.updateCustomerImage(image, id);
    if(response.error)
    throw(Exception(response.msg));
    return response.data;
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



  Future<List<Component>> getAllComponents() async{
    NetworkResponse<List<Component>> response = await _apiClient.getComponents();
    if(response.error)
      throw Exception(response.msg) ;
    return response.data ;
  }

  Future<int> deletePrescription(int id) async{
    NetworkResponse <int> response = await _apiClient.deletePrescription(id) ;
    if(response.error)
      throw(Exception(response.msg)) ;
    return response.data ;
  }

  Future<Component> addComponent(Component component) async {
    NetworkResponse<Component> response = await _apiClient.addComponent(component) ;
    if(response.error)
      throw(Exception(response.msg)) ;
    return response.data;
  }

  Future<int> deleteComponent(int id) async{
    NetworkResponse<int> response = await _apiClient.deleteComponent(id) ;
    if(response.error)
      throw(Exception(response.msg)) ;
    return response.data;
  }
}

