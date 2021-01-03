import 'dart:io';

import 'package:HealthAndBeauty/customers/events/customers_events.dart';
import 'package:HealthAndBeauty/customers/states/customers_states.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

class CustomersBloc extends Bloc<CustomersEvent, CustomerState> {
  Repository repository ;
  List<Customer> customers ;
  CustomersBloc(this.repository):super(CustomersInitState()) ;

  @override
  Stream<CustomerState> mapEventToState(CustomersEvent event) async*{
    try {
      yield CustomersLoadingState() ;
      this.customers = await repository.getAllCustomers() ;
      yield CustomersLoadedState(customers: this.customers) ;
    } 
    catch(e){
      yield _parseError(e) ;
    }
  }


  /**
   * this function maps Errors to States 
   * 
   */
  CustomerState _parseError(dynamic e){
    if(e is DioError){
      DioError dio = e ;
      switch(dio.type){
        case DioErrorType.CONNECT_TIMEOUT : 
          return CustomersErrorState(error: "connection timeout error") ; 
          break ;
        case DioErrorType.RECEIVE_TIMEOUT:
          return CustomersErrorState(error: "receive timeout error") ;
          break;
        case DioErrorType.SEND_TIMEOUT:
          return CustomersErrorState(error: "sending data timeout error") ;
          break ;
        case DioErrorType.RESPONSE: 
          return CustomersErrorState(error: "error handling response") ;
          break ;
        case DioErrorType.CANCEL:
          return CustomersErrorState(error: "request canceled error") ;
          break;
        default:
          return CustomersErrorState(error: "unknown error") ;
          break;
      }
    }
    if(e is SocketException) {
      return CustomersErrorState(error: "socket error : ${e.toString()}") ;
    }
    else {
      return CustomersErrorState(error: "Error : ${e.toString()}") ;
    }
  }

}