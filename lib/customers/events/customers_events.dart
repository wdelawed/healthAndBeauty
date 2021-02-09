import 'package:HealthAndBeauty/model/customer.dart';
import 'package:equatable/equatable.dart';

class CustomersEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class GetCustomersStartedEvent extends CustomersEvent {}

class AddCustomerStartedEvent extends CustomersEvent {
  AddCustomerStartedEvent() ;
}

class AddCustomerEvent extends CustomersEvent {
  final int index; 
  final Customer customer ;
  AddCustomerEvent(this.customer, this.index) ;
}

class DeleteCustomerEvent extends CustomersEvent {
  final int index; 
  final Customer customer ;
  DeleteCustomerEvent(this.customer, this.index) ;
}


class InsertCustomerEvent extends CustomersEvent {
  final int index; 
  final Customer customer ;
  InsertCustomerEvent(this.customer, this.index) ;
}


class DeleteCustomerStartedEvent extends CustomersEvent {
  final int index; 
  final Customer customer ;
  DeleteCustomerStartedEvent(this.customer, this.index) ;
}


class UpdateCustomerImageStartedEvent extends CustomersEvent {}

class UpdateCustomerImageEvent extends CustomersEvent {
  final int customerId ;
  final int index;
  final String imagePath ;
  UpdateCustomerImageEvent(this.customerId, this.imagePath, this.index) ;
}