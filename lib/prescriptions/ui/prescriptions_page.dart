import 'package:HealthAndBeauty/helpers/custom_colors.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/events/prescription_events.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/prescription_bloc.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/states/prescriptions_states.dart';
import 'package:HealthAndBeauty/widgets/CustomAppBar.dart';
import 'package:HealthAndBeauty/widgets/add_prescription_dialog.dart';
import 'package:HealthAndBeauty/widgets/custom_fab.dart';
import 'package:HealthAndBeauty/widgets/prescription_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrescriptionsPage extends StatefulWidget{
  
  final PrescriptionBloc _bloc = PrescriptionBloc(Repository()) ;


  @override
  _PrescriptionsPageState createState() => _PrescriptionsPageState();
}

class _PrescriptionsPageState extends State<PrescriptionsPage> {
  
  @override
  Widget build(BuildContext context) {
    widget._bloc.add(PrescriptionsIntitEvent()) ;
    return BlocProvider(
      create: (BuildContext context){return widget._bloc;},
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              CustomAppBar(
                title: "Home",
              ),
              Expanded(
                  child:  _buildBody(),
                ),
          ],)
        ),
        backgroundColor: Colors.white,
        floatingActionButton: CustomFab((){
          showDialog(context: context, builder: (context){
            return AddPrescriptionDialog();
          });
        })
    ),);
  }

  Widget _buildBody(){
    List<Widget> items = List<Widget>() ;
    List<Prescription> prescriptions = List<Prescription>();

    return BlocBuilder<PrescriptionBloc, PrescriptionState>(
      builder: (BuildContext context, PrescriptionState state){
        if(state is PrescriptionsLoadingState){
          return Container(child: Center(child: CircularProgressIndicator(backgroundColor: UiColors.main,)));
        }
        if(state is PrescriptionsLoadedState){
            prescriptions = state.prescription;
            items.add(
              Container(
                width: MediaQuery.of(context).size.width,
                height: 116, 
                child: Container(
                  padding: EdgeInsets.only(left:29),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Prescriptions", style: TextStyle(color: Color(0xff464646), fontSize: 36, fontWeight: FontWeight.w500),) , 
                      Text("you have ${prescriptions.length-1}+ prescriptions", style: TextStyle(color: Color(0xffB2B2B2), fontSize:16, fontWeight:FontWeight.w500),),
                      ], 
                    ),
                  ),
                )
              );
            
            if(prescriptions.length == 0){
              items.add(Container(child: Text("You don't have any Prescriptions"),)) ;
              return Column(children:items) ;
            }
            else {
              for(Prescription prescription in prescriptions){
                items.add(PrescriptionItem(prescription, prescription.id)) ;
              }
              return SingleChildScrollView(child:Column(children: items),) ;
            }
        }
        if(state is PrescriptionsErrorState){
          return Container(child: Center(child: Text(state.error),),) ;
        }
        return Container() ;
      },);
  }
}