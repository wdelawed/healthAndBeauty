import 'package:HealthAndBeauty/components/events/components_events.dart';
import 'package:HealthAndBeauty/components/states/components_state.dart';
import 'package:HealthAndBeauty/customers/events/customers_events.dart';
import 'package:HealthAndBeauty/customers/states/customers_states.dart';
import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/model/component.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddComponentBloc extends Bloc<ComponentEvent, ComponentState> {
  final Repository _repository ;
  AddComponentBloc(this._repository) : super(AddComponentStartState());

  @override
  Stream<ComponentState> mapEventToState(ComponentEvent event) async*{
    if(event is AddComponentStartedEvent){
        yield AddComponentStartState() ;
    }
    else if(event is AddComponentEvent)
    {
      try {
      yield AddComponentLoadingState(event.index, event.component) ;
      Component component = await _repository.addComponent(event.component) ;
      yield AddComponentSuccessState(event.index, component);
      }
      catch(e){
        yield AddComponentErrorState(event.index, event.component, Utils.parseError(e)) ;
      }
    }
    else if(event is InsertComponentEvent){
      yield AddComponentLoadingState(event.index, event.component) ;
      await Future.delayed(Duration(milliseconds: 50));
      yield AddComponentSuccessState(event.index, event.component);
    }
  }
  
}