import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/events/prescription_events.dart';
import 'package:equatable/equatable.dart';

class PrescriptionState extends Equatable{
  @override
  List<Object> get props => [] ;
}

class PrescriptionsInitState extends PrescriptionState {

}

class PrescriptionsLoadingState extends PrescriptionState {

}

class AddingPrescriptionsState extends PrescriptionState {

}

class PrescriptionsLoadedState extends PrescriptionState {
    final List<Prescription> prescription ;
    PrescriptionsLoadedState({this.prescription});
}

class PrescriptionsErrorState extends PrescriptionState {
  final String error ; 
  PrescriptionsErrorState({this.error});
}

class AddPrescriptionsErrorState extends PrescriptionsErrorState {
  AddPrescriptionsErrorState(error) : super(error : error);
}
class AddPrescriptionInitialState extends PrescriptionState {}
class AddingPrescriptionState extends PrescriptionState {}
class PrescriptionAddedState extends PrescriptionState {
  final Prescription prescription ;
  
  PrescriptionAddedState(this.prescription) ;
}



class PrescriptionDeletedState extends PrescriptionState {
  final int index ; 
  final List<Prescription> prescriptions ;
  
  PrescriptionDeletedState(this.index, this.prescriptions) ;
}
class ErrorDeletingPrescriptionState extends PrescriptionState {
  final String error ;
  ErrorDeletingPrescriptionState(this.error) ; 
}
class DeletingPrescriptionState extends PrescriptionState{}