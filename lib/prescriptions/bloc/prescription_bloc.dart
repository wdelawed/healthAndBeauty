import 'dart:io';

import 'package:HealthAndBeauty/prescriptions/bloc/events/prescription_events.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/states/prescriptions_states.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

class PrescriptionBloc extends Bloc<PrescriptionsEvent, PrescriptionState>{
  Repository repository ;
  List<Prescription> prescriptions ;
  PrescriptionBloc(this.repository) : super(PrescriptionsInitState());

  @override
  Stream<PrescriptionState> mapEventToState(PrescriptionsEvent event) async* {
    try {
      yield PrescriptionsLoadingState() ;
      this.prescriptions = await repository.getAllPrescriptions() ;
      yield PrescriptionsLoadedState(prescription: this.prescriptions) ;
    } 
    catch(e){
      yield _parseError(e) ;
    }
  }


  /**
   * this function maps Errors to States 
   * 
   */
  PrescriptionState _parseError(dynamic e){
    if(e is DioError){
      DioError dio = e ;
      switch(dio.type){
        case DioErrorType.CONNECT_TIMEOUT : 
          return PrescriptionsErrorState(error: "connection timeout error") ; 
          break ;
        case DioErrorType.RECEIVE_TIMEOUT:
          return PrescriptionsErrorState(error: "receive timeout error") ;
          break;
        case DioErrorType.SEND_TIMEOUT:
          return PrescriptionsErrorState(error: "sending data timeout error") ;
          break ;
        case DioErrorType.RESPONSE: 
          return PrescriptionsErrorState(error: "error handling response") ;
          break ;
        case DioErrorType.CANCEL:
          return PrescriptionsErrorState(error: "request canceled error") ;
          break;
        default:
          return PrescriptionsErrorState(error: "unknown error") ;
          break;
      }
    }
    if(e is SocketException) {
      return PrescriptionsErrorState(error: "socket error : ${e.toString()}") ;
    }
    else {
      return PrescriptionsErrorState(error: "Error : ${e.toString()}") ;
    }
  }
  
}