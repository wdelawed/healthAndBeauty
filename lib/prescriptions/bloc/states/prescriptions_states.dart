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

class PrescriptionMessageState extends PrescriptionState {
  final String msg ;
  PrescriptionMessageState(this.msg);
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
  final int index ;
  
  PrescriptionAddedState(this.prescription, this.index) ;
}


class DeletePrescriptionInitialState extends PrescriptionState{}
class PrescriptionDeletedState extends PrescriptionState {
  final int index ; 
  PrescriptionDeletedState(this.index) ;
}
class DeletePrescriptionErrorState extends PrescriptionState {
  final String error ;
  final int index ;
  final Prescription prescription ;
  DeletePrescriptionErrorState(this.error, this.prescription, this.index) ; 
}
class DeletingPrescriptionState extends PrescriptionState{
  final int index ;
  final Prescription prescription; 
  DeletingPrescriptionState(this.index, this.prescription);
}