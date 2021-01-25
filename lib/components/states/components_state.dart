import 'package:HealthAndBeauty/model/component.dart';
import 'package:equatable/equatable.dart';

class ComponentState extends Equatable {
  @override
  List<Object> get props =>  [];
}

class ComponentInitState extends ComponentState {
}

class ComponentLoadingState extends ComponentState {
}

class ComponentLoadedState extends ComponentState {
    final List<Component> components ;
    ComponentLoadedState(this.components) ;
}


class ComponentErrorState extends ComponentState {
    final String error ;
    ComponentErrorState(this.error) ;
}