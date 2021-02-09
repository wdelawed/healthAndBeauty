import 'package:HealthAndBeauty/model/component.dart';
import 'package:equatable/equatable.dart';

class ComponentState extends Equatable {
  @override
  List<Object> get props =>  [];
}

class GetComponentsStartState extends ComponentState {}
class GetComponentsLoadingState extends ComponentState {}
class GetComponentsSuccessState extends ComponentState {
    final List<Component> components ;
    GetComponentsSuccessState({this.components});
}
class GetComponentsErrorState extends ComponentState {
  final String error ; 
  GetComponentsErrorState({this.error});
}

class AddComponentStartState extends ComponentState {}
class AddComponentLoadingState extends ComponentState {
  final int index;
  final Component component ;
  AddComponentLoadingState(this.index, this.component);
}
class AddComponentSuccessState extends ComponentState {
  final int index;
  final Component component ;
  AddComponentSuccessState(this.index, this.component);
}
class AddComponentErrorState extends ComponentState {
  final int index;
  final Component component ;
  final String error ;
  AddComponentErrorState(this.index, this.component, this.error);
}

class DeleteComponentStartState extends ComponentState {}
class DeleteComponentLoadingState extends ComponentState {
  final int index;
  final Component component ;
  DeleteComponentLoadingState(this.index, this.component);
}
class DeleteComponentSuccessState extends ComponentState {
  final int index;
  final Component component ;
  DeleteComponentSuccessState(this.index, this.component);
}
class DeleteComponentErrorState extends ComponentState {
  final int index;
  final Component component ;
  final String error ;
  DeleteComponentErrorState(this.index, this.component, this.error);
}