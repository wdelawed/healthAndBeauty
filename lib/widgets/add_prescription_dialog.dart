import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomAppBar.dart';
import 'add_prescription_form.dart';

class AddPrescriptionDialog extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final dynamic mediaQuery = MediaQuery.of(context ) ;
    return  SingleChildScrollView(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, -1* mediaQuery.viewInsets.bottom, 0),
        child: Dialog(
            child:  Container(
              width: 310,
              child: Container(
                color: Color(0xffEFEFEF),
                child: Column(
                  children: [
                    CustomAppBar(back: false, dialog: true, title: "Add Prescription",) ,
                    AddPrescriptionForm(),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}