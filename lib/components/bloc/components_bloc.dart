import 'dart:async';

import 'package:HealthAndBeauty/components/bloc/add_component_bloc.dart';
import 'package:HealthAndBeauty/components/bloc/delete_component_bloc.dart';
import 'package:HealthAndBeauty/components/events/components_events.dart';
import 'package:HealthAndBeauty/components/states/components_state.dart';
import 'package:HealthAndBeauty/helpers/custom_colors.dart';
import 'package:HealthAndBeauty/model/component.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComponentsBloc extends Bloc<ComponentEvent, ComponentState> {
  List<Component> components;
  Repository repository;
  AddComponentBloc addBloc ;
  DeleteComponentBloc deleteBloc ;

  StreamSubscription _addSubscription ; 
  StreamSubscription _deleteSubscription ; 
  
  ComponentsBloc(this.repository) : super(GetComponentsStartState()){
      addBloc = AddComponentBloc(repository);
      deleteBloc = DeleteComponentBloc(repository); 

      _addSubscription = addBloc.listen((state){
        if(state is AddComponentSuccessState)
        {
          this.components.insert(state.index, state.component) ;
        }
      });
      _deleteSubscription = deleteBloc.listen((state){
        if(state is DeleteComponentSuccessState){
          this.components.removeAt(state.index);
        }
      }) ;
  }

  @override
  Stream<ComponentState> mapEventToState(ComponentEvent event) async* {
    if (event is GetComponentsStartedEvent) {
      try {
        yield GetComponentsLoadingState();
        components = await repository.getAllComponents();
        yield GetComponentsSuccessState(components: this.components);
        for (int i = 0 ; i < components.length ; i++)
          addBloc.add(InsertComponentEvent(components[i], i));
      } catch (e) {
        yield GetComponentsErrorState(error: Helper.parseError(e));
      }
    }
     else if(event is AddComponentStartedEvent){
      addBloc.add(event) ;
    }
    else if(event is DeleteComponentStartedEvent){
      deleteBloc.add(event) ;
    }
   
    else if(event is AddComponentEvent){
      addBloc.add(event) ;
    }
    else if(event is DeleteComponentEvent){
      deleteBloc.add(event) ;
    }
  }

  @override 
  Future<void> close() {
      _addSubscription.cancel();
      _deleteSubscription.cancel();
      return super.close();
    }
}
