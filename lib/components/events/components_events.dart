import 'package:HealthAndBeauty/model/component.dart';
import 'package:equatable/equatable.dart';

class ComponentEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class GetComponentsStartedEvent extends ComponentEvent {}

class AddComponentStartedEvent extends ComponentEvent {
  AddComponentStartedEvent() ;
}

class AddComponentEvent extends ComponentEvent {
  final int index; 
  final Component component ;
  AddComponentEvent(this.component, this.index) ;
}

class DeleteComponentStartedEvent extends ComponentEvent {
  final int index; 
  final Component component ;
  DeleteComponentStartedEvent(this.component, this.index) ;
}

class DeleteComponentEvent extends ComponentEvent {
  final int index; 
  final Component component ;
  DeleteComponentEvent(this.component, this.index) ;
}


class InsertComponentEvent extends ComponentEvent {
  final int index; 
  final Component component ;
  InsertComponentEvent(this.component, this.index) ;
}