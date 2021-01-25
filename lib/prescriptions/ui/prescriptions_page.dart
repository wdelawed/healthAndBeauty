import 'package:HealthAndBeauty/bloc/app_bloc.dart';
import 'package:HealthAndBeauty/helpers/custom_colors.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/events/prescription_events.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/prescription_bloc.dart';
import 'package:HealthAndBeauty/prescriptions/bloc/states/prescriptions_states.dart';
import 'package:HealthAndBeauty/widgets/add_prescription_dialog.dart';
import 'package:HealthAndBeauty/widgets/custom_fab.dart';
import 'package:HealthAndBeauty/widgets/prescription_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrescriptionsPage extends StatelessWidget {

  List<Prescription> prescriptions ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      backgroundColor: Colors.white,
      floatingActionButton: CustomFab(
        () {
          BlocProvider.of<AppBloc>(context).prescriptionBloc.add(AddPrescriptionStartedEvent()) ;
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
    return BlocBuilder<PrescriptionBloc, PrescriptionState>(
      cubit: BlocProvider.of<AppBloc>(context).prescriptionBloc,
      builder: (context, state) {
        if (state is PrescriptionsLoadingState)
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: UiColors.main,
            ),
          );
        if (state is PrescriptionsLoadedState){
          prescriptions = List<Prescription>.from(state.prescription);
          
        }
        else if (state is PrescriptionsErrorState && prescriptions == null)
          return Center(
            child: Text("Failed to load your data \n ${state.error}"),
          );
        return _buildList(context);
      },
    );
  }

  Widget _buildList(context) {
    if(prescriptions == null )
    return Container() ;
    print("Prescriptions Page Rebuild");
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
                      "you have ${prescriptions.length} prescriptions",
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
        
        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index){
            return PrescriptionItem(prescriptions[index], index);
          },
          childCount: prescriptions.length,
        ),) ,

      ],
    );
  }
}
