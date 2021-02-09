import 'package:HealthAndBeauty/model/customer.dart';
import 'package:equatable/equatable.dart';

class CustomerState extends Equatable{
  @override
  List<Object> get props => [] ;
}

class GetCustomersStartState extends CustomerState {}
class GetCustomersLoadingState extends CustomerState {}
class GetCustomersSuccessState extends CustomerState {
    final List<Customer> customers ;
    GetCustomersSuccessState({this.customers});
}
class GetCustomersErrorState extends CustomerState {
  final String error ; 
  GetCustomersErrorState({this.error});
}

class AddCustomerStartState extends CustomerState {}
class AddCustomerLoadingState extends CustomerState {
  final int index;
  final Customer customer ;
  AddCustomerLoadingState(this.index, this.customer);
}
class AddCustomerSuccessState extends CustomerState {
  final int index;
  final Customer customer ;
  AddCustomerSuccessState(this.index, this.customer);
}
class AddCustomerErrorState extends CustomerState {
  final int index;
  final Customer customer ;
  final String error ;
  AddCustomerErrorState(this.index, this.customer, this.error);
}

class DeleteCustomerStartState extends CustomerState {}
class DeleteCustomerLoadingState extends CustomerState {
  final int index;
  final Customer customer ;
  DeleteCustomerLoadingState(this.index, this.customer);
}
class DeleteCustomerSuccessState extends CustomerState {
  final int index;
  final Customer customer ;
  DeleteCustomerSuccessState(this.index, this.customer);
}
class DeleteCustomerErrorState extends CustomerState {
  final int index;
  final Customer customer ;
  final String error ;
  DeleteCustomerErrorState(this.index, this.customer, this.error);
}


class UpdateCustomerImageStartState extends CustomerState {}
class UpdateCustomerImageLoadingState extends CustomerState {
  UpdateCustomerImageLoadingState();
}
class UpdateCustomerImageSuccessState extends CustomerState {
  final int index;
  final Customer customer ;
  UpdateCustomerImageSuccessState(this.index, this.customer);
}
class UpdateCustomerImageErrorState extends CustomerState {
  final int index;
  final int customerId ;
  final String error ;
  UpdateCustomerImageErrorState(this.index, this.customerId, this.error);
}