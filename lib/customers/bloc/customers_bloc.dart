import 'dart:async';

import 'package:HealthAndBeauty/customers/bloc/add_customer_bloc.dart';
import 'package:HealthAndBeauty/customers/bloc/update_customer_image_bloc.dart';
import 'package:HealthAndBeauty/customers/events/customers_events.dart';
import 'package:HealthAndBeauty/customers/states/customers_states.dart';
import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:bloc/bloc.dart';

import 'delete_customer_bloc.dart';

class CustomersBloc extends Bloc<CustomersEvent, CustomerState> {
  Repository repository;
  List<Customer> customers = List<Customer>();
  AddCustomerBloc _addBloc;
  DeleteCustomerBloc _deleteBloc;
  UpdateCustomerImageBloc _updateImageBloc;
  StreamSubscription _addSubscription;
  StreamSubscription _deleteSubscription;
  StreamSubscription _updateSubscriptions;
  CustomersBloc(this.repository) : super(GetCustomersStartState()) {
    _addBloc = AddCustomerBloc(this.repository);
    _deleteBloc = DeleteCustomerBloc(this.repository);
    _updateImageBloc = UpdateCustomerImageBloc(this.repository);
    _addSubscription = _addBloc.listen((state) {
      if (state is AddCustomerSuccessState) {
        this.customers.insert(0, state.customer);
      }
    });
    _deleteSubscription = _deleteBloc.listen((state) {
      if (state is DeleteCustomerSuccessState) {
        this.customers.removeAt(state.index);
      }
    });
    _updateSubscriptions = _updateImageBloc.listen((state) {
      if (state is UpdateCustomerImageSuccessState) {
        this.customers[state.index] = state.customer ;
      }
    });
  }

  AddCustomerBloc get addBloc {
    return _addBloc;
  }

  DeleteCustomerBloc get deleteBloc {
    return _deleteBloc;
  }

  UpdateCustomerImageBloc get updateBloc {
    return _updateImageBloc;
  }

  @override
  Stream<CustomerState> mapEventToState(CustomersEvent event) async* {
    if (event is GetCustomersStartedEvent) {
      try {
        yield GetCustomersLoadingState();
        List<Customer> _customers = await repository.getAllCustomers();
        yield GetCustomersSuccessState(customers: _customers);
        for (int i = 0; i < _customers.length; i++)
          _addBloc.add(InsertCustomerEvent(_customers[i], i));
      } catch (e) {
        yield GetCustomersErrorState(error: Utils.parseError(e));
      }
    }
    else if(event is AddCustomerStartedEvent){
      _addBloc.add(event) ;
    }
    else if(event is DeleteCustomerStartedEvent){
      _deleteBloc.add(event) ;
    }
   
    else if(event is AddCustomerEvent){
      _addBloc.add(event) ;
    }
    else if(event is DeleteCustomerEvent){
      _deleteBloc.add(event) ;
    }
  }

  @override
  Future<void> close() {
    _addSubscription.cancel();
    _deleteSubscription.cancel();
    _updateSubscriptions.cancel();
    return super.close();
  }
}
