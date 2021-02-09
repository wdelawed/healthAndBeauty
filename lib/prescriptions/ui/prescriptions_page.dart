import 'package:HealthAndBeauty/bloc/app_bloc.dart';
import 'package:HealthAndBeauty/helpers/custom_colors.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/add_prescription_bloc.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/delete_prescription_bloc.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/events/prescription_events.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/prescription_bloc.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/states/prescriptions_states.dart';
import 'package:HealthAndBeauty/widgets/add_prescription_dialog.dart';
import 'package:HealthAndBeauty/widgets/custom_fab.dart';
import 'package:HealthAndBeauty/widgets/prescription_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PrescriptionsPage extends StatefulWidget {
  @override
  _PrescriptionsPageState createState() => _PrescriptionsPageState();
}

class _PrescriptionsPageState extends State<PrescriptionsPage> {
  List<Prescription> prescriptions = List<Prescription>();
  final LabeledGlobalKey<SliverAnimatedListState> _listKey = LabeledGlobalKey<SliverAnimatedListState>("Prescriptions SliverAnimatedList");

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      backgroundColor: Colors.white,
      floatingActionButton: CustomFab(
        () {
          BlocProvider.of<AppBloc>(context)
              .prescriptionBloc
              .add(AddPrescriptionStartedEvent());
          showDialog(
            context: context,
            builder: (context) {
              return AddPrescriptionDialog();
            },
          );
        },
      ),
    );
  }

  Widget _buildBody(context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PrescriptionBloc, PrescriptionState>(
          cubit: BlocProvider.of<AppBloc>(context).prescriptionBloc,
          listener: (context, state) {},
        ),
        BlocListener<AddPrescriptionBloc, PrescriptionState>(
          cubit: BlocProvider.of<AppBloc>(context).prescriptionBloc.addBloc,
          listener: (context, state) {
            if (state is PrescriptionAddedState) {
              this.prescriptions.insert(state.index, state.prescription);
              _listKey.currentState.insertItem(state.index);
            } else if (state is AddPrescriptionsErrorState) {
              Fluttertoast.showToast(
                msg: "Error: ${state.error}",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
              );
            }
          },
        ),
        BlocListener<DeletePrescriptionBloc, PrescriptionState>(
          cubit: BlocProvider.of<AppBloc>(context).prescriptionBloc.deleteBloc,
          listener: (context, state) {
            if (state is DeletePrescriptionErrorState) {
              Fluttertoast.showToast(
                msg: "Error: ${state.error}",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
              );
              this.prescriptions.insert(state.index, state.prescription);
              _listKey.currentState.insertItem(state.index) ;
            } else if (state is PrescriptionDeletedState) {
              //handle deletion success logic here
              Fluttertoast.showToast(
                msg: "Deleted Succsessfully",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
              );
            }
            else if(state is DeletingPrescriptionState){
              this.prescriptions.removeAt(state.index) ;
              _listKey.currentState.removeItem(state.index, (context, animation) => Container()) ;
            }
          },
        ),
      ],
      child: BlocBuilder<PrescriptionBloc, PrescriptionState>(
        cubit: BlocProvider.of<AppBloc>(context).prescriptionBloc,
        builder: (context, state) {
          if (state is PrescriptionsLoadedState) {
            return _buildList(context, state.prescription);
          } else if (state is PrescriptionsErrorState)
            return Center(
              child: Text("Failed to load your data \n ${state.error}"),
            );
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: UiColors.main,
            ),
          );
        },
      ),
    );
  }

  Widget _buildList(context, List<Prescription> data) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          elevation: 0,
          stretch: true,
          floating: false,
          backgroundColor: Colors.white,
          expandedHeight: 216,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 100),
              width: MediaQuery.of(context).size.width,
              height: 216,
              child: Container(
                padding: EdgeInsets.only(left: 29),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Prescriptions",
                      style: TextStyle(
                          color: Color(0xff464646),
                          fontSize: 36,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "you have ${data.length} prescriptions",
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
        data.isNotEmpty
            ? SliverAnimatedList(
                key: _listKey,
                initialItemCount: 0,
                itemBuilder: (context, index, animation) {
                  return _buildItem(prescriptions[index], index, animation);
                },
              )
            : Container(
                child: Center(
                  child: Text(
                    "Youd don't have any Prescriptions",
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildItem(Prescription item, index, animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(animation),
      child: PrescriptionItem(
        item,
        index,
      ),
    );
  }
}
