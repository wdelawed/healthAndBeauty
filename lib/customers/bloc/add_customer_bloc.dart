import 'package:HealthAndBeauty/customers/events/customers_events.dart';
import 'package:HealthAndBeauty/customers/states/customers_states.dart';
import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCustomerBloc extends Bloc<CustomersEvent, CustomerState> {
  final Repository _repository ;
  AddCustomerBloc(this._repository) : super(AddCustomerStartState());

  @override
  Stream<CustomerState> mapEventToState(CustomersEvent event) async*{
    if(event is AddCustomerStartedEvent){
        yield AddCustomerStartState() ;
    }
    else if(event is AddCustomerEvent)
    {
      try {
      yield AddCustomerLoadingState(event.index, event.customer) ;
      Customer customer = await _repository.addCustomer(event.customer) ;
      yield AddCustomerSuccessState(event.index, customer);
      }
      catch(e){
        yield AddCustomerErrorState(event.index, event.customer, Utils.parseError(e)) ;
      }
    }
    else if(event is InsertCustomerEvent){
      yield AddCustomerLoadingState(event.index, event.customer) ;
      await Future.delayed(Duration(milliseconds: 50));
      yield AddCustomerSuccessState(event.index, event.customer);
    }
  }
  
}