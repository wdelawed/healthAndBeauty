import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/events/prescription_events.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/states/prescriptions_states.dart';
import 'package:bloc/bloc.dart';

class DeletePrescriptionBloc extends Bloc<PrescriptionsEvent, PrescriptionState>{
  final Repository _repository ;
  DeletePrescriptionBloc(this._repository) : super(AddPrescriptionInitialState());


  @override
  Stream<PrescriptionState> mapEventToState(PrescriptionsEvent event) async*{
    if(event is DeletePrescriptionStartedEvent){
      yield DeletePrescriptionInitialState();
    }
    else if(event is DeletePrescriptionEvent)
    {
      try {
        yield DeletingPrescriptionState(event.index, event.item) ;
        await _repository.deletePrescription(event.item.id) ;
        yield PrescriptionDeletedState(event.index) ;
      }
      catch (e) {
        yield DeletePrescriptionErrorState(e.toString(), event.item, event.index) ;
      }
    }
  }

 @override 
  void onTransition(Transition<PrescriptionsEvent, PrescriptionState> transition) {
    print("{ DeletePrescription : $transition}") ;
    super.onTransition(transition);
  }
  
}