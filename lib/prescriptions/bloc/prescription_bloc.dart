import 'dart:async';

import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/add_prescription_bloc.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/delete_prescription_bloc.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/events/prescription_events.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/states/prescriptions_states.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:bloc/bloc.dart';

class PrescriptionBloc extends Bloc<PrescriptionsEvent, PrescriptionState> {
  Repository repository;
  List<Prescription> prescriptions = List<Prescription>();
  AddPrescriptionBloc _bloc ;
  DeletePrescriptionBloc _deletionBloc ;
  StreamSubscription _subscription;
  StreamSubscription _d_subscription;
  PrescriptionBloc(this.repository) : super(PrescriptionsInitState()){
    _bloc = AddPrescriptionBloc(this.repository) ;
    _deletionBloc = DeletePrescriptionBloc(this.repository) ;
    _subscription =_bloc.listen((state) { 
      if(state is PrescriptionAddedState){
        this.prescriptions.add(state.prescription) ;
      }
    });
    _d_subscription = _deletionBloc.listen((state) {
        if(state is PrescriptionDeletedState){
          this.prescriptions.removeAt(state.index) ;
        } 
    }) ;
  }

  AddPrescriptionBloc get addBloc {
    return _bloc ;
  }

  DeletePrescriptionBloc get deleteBloc {
    return _deletionBloc ;
  }

  @override
  Stream<PrescriptionState> mapEventToState(PrescriptionsEvent event) async* {
    if (event is PrescriptionsIntitEvent) {
      try {
        yield PrescriptionsLoadingState();
        List<Prescription> _prescriptions = await repository.getAllPrescriptions();
        yield PrescriptionsLoadedState(prescription: _prescriptions);
        for(int i = 0 ; i< _prescriptions.length; i++)
          _bloc.add(InsertPrescriptionEvent(_prescriptions[i], index: i)) ;
      } catch (e) {
        yield PrescriptionsErrorState(error: Utils.parseError(e));
      }
    } else if (event is AddPrescriptionStartedEvent) {
        _bloc.add(AddPrescriptionStartedEvent());
      
    } 
    else if(event is AddPrescriptionEvent){
      _bloc.add(event);
    }
    else if(event is DeletePrescriptionEvent){
      _deletionBloc.add(event);
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
     _d_subscription.cancel();
     super.close();
   }
}
