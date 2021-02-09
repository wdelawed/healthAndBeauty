import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/events/prescription_events.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/states/prescriptions_states.dart';
import 'package:bloc/bloc.dart';

class AddPrescriptionBloc extends Bloc<PrescriptionsEvent, PrescriptionState>{
  final Repository _repository ;
  AddPrescriptionBloc(this._repository) : super(AddPrescriptionInitialState());


  @override
  Stream<PrescriptionState> mapEventToState(PrescriptionsEvent event) async*{
    if(event is AddPrescriptionStartedEvent){
      yield AddPrescriptionInitialState();
    }
    else if(event is AddPrescriptionEvent)
    {
      try {
        yield AddingPrescriptionsState() ;
        Prescription pres = await _repository.addPrescription(event.prescription) ;
        yield PrescriptionAddedState(pres, event.index) ;
      }
      catch (e) {
        yield AddPrescriptionsErrorState(Utils.parseError(e)) ;
      }
    }
    else if(event is InsertPrescriptionEvent){
      yield AddingPrescriptionsState();
      await Future.delayed(Duration(milliseconds: 50));
      yield PrescriptionAddedState(event.prescription, event.index) ;
    }
  }

 @override 
  void onTransition(Transition<PrescriptionsEvent, PrescriptionState> transition) {
    print("{ AddPrescription : $transition}") ;
    super.onTransition(transition);
  }
  
}