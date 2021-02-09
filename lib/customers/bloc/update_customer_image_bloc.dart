import 'package:HealthAndBeauty/customers/events/customers_events.dart';
import 'package:HealthAndBeauty/customers/states/customers_states.dart';
import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:bloc/bloc.dart';

class UpdateCustomerImageBloc extends Bloc<CustomersEvent, CustomerState> {
  final Repository _repository;
  UpdateCustomerImageBloc(this._repository)
      : super(UpdateCustomerImageStartState());

  @override
  Stream<CustomerState> mapEventToState(CustomersEvent event) async* {
    if (event is UpdateCustomerImageStartedEvent) {
      yield UpdateCustomerImageStartState();
    } else if (event is UpdateCustomerImageEvent) {
      try {
        yield UpdateCustomerImageLoadingState();
        Customer customer = await _repository.updateCustomerImage(
            event.imagePath, event.customerId);
        yield UpdateCustomerImageSuccessState(event.index, customer);
      } catch (e) {
        yield UpdateCustomerImageErrorState(event.index, event.customerId, Utils.parseError(e));
      }
    }
  }
}
