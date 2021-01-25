import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:equatable/equatable.dart';

class PrescriptionsEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class PrescriptionsIntitEvent extends PrescriptionsEvent {}



class AddPrescriptionStartedEvent extends PrescriptionsEvent {}
class DeletePrescriptionStartedEvent extends PrescriptionsEvent {}
class ReloadPrescriptionsEvent extends PrescriptionsEvent {}

class AddPrescriptionEvent extends PrescriptionsEvent {
  final Prescription prescription ;
  AddPrescriptionEvent(this.prescription) ;
}

class DeletePrescriptionEvent extends PrescriptionsEvent {
  final int index ; 
  final Prescription item ;
  DeletePrescriptionEvent(this.item, this.index) ;
}
