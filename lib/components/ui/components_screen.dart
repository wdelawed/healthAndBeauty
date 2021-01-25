import 'package:HealthAndBeauty/components/bloc/components_bloc.dart';
import 'package:HealthAndBeauty/components/events/components_events.dart';
import 'package:HealthAndBeauty/components/states/components_state.dart';
import 'package:HealthAndBeauty/model/component.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:HealthAndBeauty/widgets/custom_fab.dart';
import 'package:HealthAndBeauty/widgets/prescription_component_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComponentsScreen extends StatefulWidget {
  ComponentsBloc _bloc = ComponentsBloc(Repository());

  @override
  _ComponentsScreenState createState() => _ComponentsScreenState();
}

class _ComponentsScreenState extends State<ComponentsScreen> {
  @override
  dynamic dispose() { 

    super.dispose();
    widget._bloc.close();
  }

  @override
  void initState() {
    super.initState();
    widget._bloc.add(ComponentInitEvent());
  }

  List<Component> components = List<Component>();
  GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ComponentsBloc>(
      create: (BuildContext context) {
        return widget._bloc;
      },
      child: Scaffold(
        floatingActionButton: CustomFab((){}),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                BlocBuilder<ComponentsBloc, ComponentState>(
                  builder: (BuildContext context, ComponentState state) {
                    if (state is ComponentLoadingState) {
                      return Expanded(
                        child: Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    }
                    if (state is ComponentLoadedState) {
                      this.components = state.components;
                      if (components.isEmpty) {
                        return Expanded(
                          child: Container(
                            child: Center(
                              child: Text("You don't have any components yet"),
                            ),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 100),
                                  width: MediaQuery.of(context).size.width,
                                  height: 116,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 29),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Components",
                                          style: TextStyle(
                                              color: Color(0xff464646),
                                              fontSize: 36,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "you have ${components.length}+ components",
                                          style: TextStyle(
                                              color: Color(0xffB2B2B2),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      itemCount: this.components.length,
                                      key: _key,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return PrescriptionComponentWidget(
                                          this.components[index],
                                          id: index + 1,
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    }
                    if (state is ComponentErrorState) {
                      String error = state.error;
                      return Expanded(
                        child: Container(child: Center(child: Text("$error"))),
                      );
                    }
                    return Container(
                      color: Colors.blue,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
