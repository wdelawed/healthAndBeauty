import 'package:HealthAndBeauty/components/events/components_events.dart';
import 'package:HealthAndBeauty/components/states/components_state.dart';
import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteComponentBloc extends Bloc<ComponentEvent, ComponentState> {
  final Repository _repository ;
  DeleteComponentBloc(this._repository) : super(DeleteComponentStartState());

  @override
  Stream<ComponentState> mapEventToState(ComponentEvent event) async*{
    if(event is DeleteComponentStartedEvent){
        yield DeleteComponentStartState() ;
    }
    else if(event is DeleteComponentEvent)
    {
      try {
      yield DeleteComponentLoadingState(event.index, event.component) ;
      await _repository.deleteComponent(event.component.id) ;
      yield DeleteComponentSuccessState(event.index, event.component);
      }
      catch(e){
        yield DeleteComponentErrorState(event.index, event.component, Utils.parseError(e)) ;
      }
    }
  }
  
}