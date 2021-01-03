import 'package:HealthAndBeauty/model/customer.dart';
import 'package:equatable/equatable.dart';

class CustomerState extends Equatable{
  @override
  List<Object> get props => [] ;
}

class CustomersInitState extends CustomerState {

}

class CustomersLoadingState extends CustomerState {

}

class CustomersLoadedState extends CustomerState {
    final List<Customer> customers ;
    CustomersLoadedState({this.customers});
}

class CustomersErrorState extends CustomerState {
  final String error ; 
  CustomersErrorState({this.error});
}
