import 'package:HealthAndBeauty/bloc/app_bloc.dart';
import 'package:HealthAndBeauty/components/bloc/add_component_bloc.dart';
import 'package:HealthAndBeauty/components/bloc/components_bloc.dart';
import 'package:HealthAndBeauty/components/bloc/delete_component_bloc.dart';
import 'package:HealthAndBeauty/components/events/components_events.dart';
import 'package:HealthAndBeauty/components/states/components_state.dart';
import 'package:HealthAndBeauty/helpers/custom_colors.dart';
import 'package:HealthAndBeauty/model/component.dart';
import 'package:HealthAndBeauty/widgets/add_component_dialog.dart';
import 'package:HealthAndBeauty/widgets/component_widget.dart';
import 'package:HealthAndBeauty/widgets/custom_fab.dart';
import 'package:HealthAndBeauty/widgets/page_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ComponentsScreen extends StatefulWidget {
  @override
  _ComponentsScreenState createState() => _ComponentsScreenState();
}

class _ComponentsScreenState extends State<ComponentsScreen> {
  List<Component> components = List<Component>();
  LabeledGlobalKey<SliverAnimatedListState> _listKey =
      LabeledGlobalKey<SliverAnimatedListState>("components list");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFab(() {
        BlocProvider.of<AppBloc>(context)
              .componentsBloc
              .add(AddComponentStartedEvent());
          Navigator.push(
            context,
            AppPageRoute(
              builder: (context) {
                return AddComponentDialog();
              },
            ),
          );
      }),
      backgroundColor: Colors.white,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AddComponentBloc, ComponentState>(
            cubit: BlocProvider.of<AppBloc>(context).componentsBloc.addBloc,
            listener: (context, state) {
              if (state is AddComponentSuccessState) {
                this.components.insert(state.index, state.component);
                _listKey.currentState.insertItem(state.index);
              } else if (state is AddComponentErrorState) {
                Fluttertoast.showToast(
                  msg: "Error: ${state.error}",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                );
              }
            },
          ),
          BlocListener<DeleteComponentBloc, ComponentState>(
            cubit: BlocProvider.of<AppBloc>(context).componentsBloc.deleteBloc,
            listener: (context, state) {
              if (state is DeleteComponentErrorState) {
                Fluttertoast.showToast(
                  msg: "Error: ${state.error}",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                );
                this.components.insert(state.index, state.component);
                _listKey.currentState.insertItem(state.index);
              } else if (state is DeleteComponentSuccessState) {
                //handle deletion success logic here
                Fluttertoast.showToast(
                  msg: "Deleted Succsessfully",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                );
              } else if (state is DeleteComponentLoadingState) {
                this.components.removeAt(state.index);
                _listKey.currentState.removeItem(
                  state.index,
                  (context, animation) => FadeTransition(
                    opacity: animation,
                    child: ComponentWidget(state.index, state.component),
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<ComponentsBloc, ComponentState>(
          cubit: BlocProvider.of<AppBloc>(context).componentsBloc,
          builder: (BuildContext context, ComponentState state) {
            if (state is GetComponentsSuccessState) {
              return _buildComponentsList(state.components);
            } else if (state is GetComponentsErrorState) {
              String error = state.error;
              return Container(
                  child: Center(
                child: Text("$error"),
              ));
            }
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: UiColors.main,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildComponentsList(List<Component> data) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 216,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 100),
              width: MediaQuery.of(context).size.width,
              height: 116,
              child: Container(
                padding: EdgeInsets.only(left: 29),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Components",
                      style: TextStyle(
                          color: Color(0xff464646),
                          fontSize: 36,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "you have ${data.length}+ components",
                      style: TextStyle(
                          color: Color(0xffB2B2B2),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverAnimatedList(
          key: _listKey,
          itemBuilder: (_, index, animation) {
            return FadeTransition(
              opacity: animation,
              child: ComponentWidget(index, components[index]),
            );
          },
        )
      ],
    );
  }
}
