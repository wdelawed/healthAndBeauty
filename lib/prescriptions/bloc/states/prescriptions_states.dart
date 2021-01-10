import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:equatable/equatable.dart';

class PrescriptionState extends Equatable{
  @override
  List<Object> get props => [] ;
}

class PrescriptionsInitState extends PrescriptionState {

}

class PrescriptionsLoadingState extends PrescriptionState {

}

class PrescriptionsLoadedState extends PrescriptionState {
    final List<Prescription> prescription ;
    PrescriptionsLoadedState({this.prescription});
}

class PrescriptionsErrorState extends PrescriptionState {
  final String error ; 
  PrescriptionsErrorState({this.error});
}
