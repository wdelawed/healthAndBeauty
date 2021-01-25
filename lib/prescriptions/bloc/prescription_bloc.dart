import 'dart:async';

import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/add_prescription_bloc.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/events/prescription_events.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/states/prescriptions_states.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:bloc/bloc.dart';

class PrescriptionBloc extends Bloc<PrescriptionsEvent, PrescriptionState> {
  Repository repository;
  List<Prescription> prescriptions = List<Prescription>();
  AddPrescriptionBloc _bloc ;
  StreamSubscription _subscription;
  PrescriptionBloc(this.repository) : super(PrescriptionsInitState()){
    _bloc = AddPrescriptionBloc(this.repository) ;
    _subscription =_bloc.listen((state) { 
      if(state is PrescriptionAddedState){
        this.prescriptions.add(state.prescription) ;
        this.add(ReloadPrescriptionsEvent()) ;
      }
    });
  }

  AddPrescriptionBloc get bloc {
    return _bloc ;
  }

  @override
  Stream<PrescriptionState> mapEventToState(PrescriptionsEvent event) async* {
    if (event is PrescriptionsIntitEvent) {
      try {
        yield PrescriptionsLoadingState();
        this.prescriptions = await repository.getAllPrescriptions();
        yield PrescriptionsLoadedState(prescription: this.prescriptions);
      } catch (e) {
        yield PrescriptionsErrorState(error: Utils.parseError(e));
      }
    } else if (event is AddPrescriptionStartedEvent) {
        _bloc.add(AddPrescriptionStartedEvent());
      
    } 
    else if(event is AddPrescriptionEvent){
      _bloc.add(event);
    }
    else if (event is ReloadPrescriptionsEvent) {
        yield PrescriptionsLoadingState() ;
        Future.delayed(Duration(milliseconds: 1000)) ;
        yield PrescriptionsLoadedState(prescription: this.prescriptions) ;
    }
  }
  @override 
  void onTransition(Transition<PrescriptionsEvent, PrescriptionState> transition) {
    print("{ PrescriptionBloc : $transition}") ;
    super.onTransition(transition);
  }

  @override
   close() async{
     _subscription.cancel() ;
     super.close();
   }
}
