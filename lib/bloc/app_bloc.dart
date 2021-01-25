import 'package:HealthAndBeauty/components/bloc/components_bloc.dart';
import 'package:HealthAndBeauty/components/events/components_events.dart';
import 'package:HealthAndBeauty/customers/bloc/customers_bloc.dart';
import 'package:HealthAndBeauty/customers/events/customers_events.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/events/prescription_events.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/prescription_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {

  final Repository _repository ;
   CustomersBloc customersBloc ;
   ComponentsBloc componentsBloc ;
    PrescriptionBloc prescriptionBloc ;


  AppBloc(this._repository) :super(AppState()){
    customersBloc = CustomersBloc(_repository) ;
    componentsBloc = ComponentsBloc(_repository) ;
    prescriptionBloc = PrescriptionBloc(_repository) ;
  }



  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    yield AppInitState() ;
    customersBloc.add(CustomersIntitEvent()) ;
    componentsBloc.add(ComponentInitEvent()) ;
    prescriptionBloc.add(PrescriptionsIntitEvent()) ;
    yield AppInitializedState();
  }

 @override
 Future<void> close() {
    customersBloc.close() ;
    componentsBloc.close();
    prescriptionBloc.close();
    return super.close();
  }

}

class AppState extends Equatable {
  @override
  List<Object> get props => [];
}

class AppInitState extends AppState{}
class AppInitializedState extends AppState{}
class AppInitEvent extends AppEvent{}

class AppEvent extends Equatable {
  @override
  List<Object> get props => [];
}

