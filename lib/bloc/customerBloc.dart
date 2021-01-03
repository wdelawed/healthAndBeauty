import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/model/networkResponse.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:rxdart/rxdart.dart';

class CustomerBloc {
  Repository _repository = Repository() ;
  final _customerFetcher  = PublishSubject<NetworkResponse<Customer>>() ;
  Observable<NetworkResponse<Customer>> get customer => _customerFetcher.stream ;

  fetchCustomer(int id) async {
    NetworkResponse<Customer> response = await _repository.getCustomer(id) ;
    return _customerFetcher.sink.add(response) ;
  }

  dispose (){
    _customerFetcher.close();
  }
}

CustomerBloc customerBloc = CustomerBloc() ;