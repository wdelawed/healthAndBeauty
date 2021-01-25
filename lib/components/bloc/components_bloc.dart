import 'package:HealthAndBeauty/components/events/components_events.dart';
import 'package:HealthAndBeauty/components/states/components_state.dart';
import 'package:HealthAndBeauty/helpers/custom_colors.dart';
import 'package:HealthAndBeauty/model/component.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComponentsBloc extends Bloc<ComponentEvent, ComponentState> {
  List<Component> components;
  Repository repository;
  ComponentsBloc(this.repository) : super(ComponentInitState());

  @override
  Stream<ComponentState> mapEventToState(ComponentEvent event) async* {
    if (event is ComponentInitEvent) {
      try {
        yield ComponentLoadingState();
        this.components = await repository.getAllComponents();
        yield ComponentLoadedState(this.components);
      } catch (e) {
        yield ComponentErrorState(Helper.parseError(e));
      }
    }
  }


}
