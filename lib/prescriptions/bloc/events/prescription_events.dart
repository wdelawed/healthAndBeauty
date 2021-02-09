import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:equatable/equatable.dart';

class PrescriptionsEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class PrescriptionsIntitEvent extends PrescriptionsEvent {}
class ReloadPrescriptionsEvent extends PrescriptionsEvent {
  final String msg ;
  ReloadPrescriptionsEvent(this.msg) ;
}


class AddPrescriptionStartedEvent extends PrescriptionsEvent {}
class AddPrescriptionEvent extends PrescriptionsEvent {
  final Prescription prescription ;
  final index ;
  AddPrescriptionEvent(this.prescription, {this.index = 0}) ;
}

class InsertPrescriptionEvent extends PrescriptionsEvent {
  final Prescription prescription ;
  final index ;
  InsertPrescriptionEvent(this.prescription, {this.index = 0}) ;
}


class DeletePrescriptionEvent extends PrescriptionsEvent {
  final int index ; 
  final Prescription item ;
  DeletePrescriptionEvent(this.item, this.index) ;
}
class DeletePrescriptionStartedEvent extends PrescriptionsEvent {}