import 'package:HealthAndBeauty/customers/events/customers_events.dart';
import 'package:HealthAndBeauty/customers/states/customers_states.dart';
import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteCustomerBloc extends Bloc<CustomersEvent, CustomerState> {
  final Repository _repository ;
  DeleteCustomerBloc(this._repository) : super(DeleteCustomerStartState());

  @override
  Stream<CustomerState> mapEventToState(CustomersEvent event) async*{
    if(event is DeleteCustomerStartedEvent){
        yield DeleteCustomerStartState() ;
    }
    else if(event is DeleteCustomerEvent)
    {
      try {
      yield DeleteCustomerLoadingState(event.index, event.customer) ;
      await _repository.deleteCustomer(event.customer.id) ;
      yield DeleteCustomerSuccessState(event.index, event.customer);
      }
      catch(e){
        yield DeleteCustomerErrorState(event.index, event.customer, Utils.parseError(e)) ;
      }
    }
  }
  
}