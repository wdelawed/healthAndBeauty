import 'package:HealthAndBeauty/widgets/CustomAppBar.dart';
import 'package:HealthAndBeauty/widgets/assign_prescription_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssignPrescDialog extends StatelessWidget{
  MediaQueryData mediaQuery ;
  BuildContext providerContext;
  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context) ;
    return  AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            transform: Matrix4.translationValues(0.0, (mediaQuery.viewInsets.bottom - ((mediaQuery.size.height-583)/2))* -1, 0.0,),
            child:SingleChildScrollView(
            child:  Dialog(
              child: Container(
                width: 310,
                height: 583,
                color: Color(0xffEFEFEF),
                child: Column(
                  children: [
                    CustomAppBar(back: false, dialog: true, title: "Prescribe",) ,
                    AssignPrescriptionForm(),
                  ],
                ),
              ),
          ),
        ),
    );
  }
}