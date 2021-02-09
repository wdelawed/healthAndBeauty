import 'package:HealthAndBeauty/widgets/add_component_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomAppBar.dart';

class AddComponentDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(.3),
      body: SingleChildScrollView(
          child: Dialog(
            child: Container(
              width: 310,
              child: Container(
                color: Color(0xffEFEFEF),
                child: Column(
                  children: [
                    CustomAppBar(
                      back: false,
                      dialog: true,
                      title: "Add new Component",
                    ),
                    AddComponentForm(),
                  ],
                ),
              ),
            ),
          ),
      
      ),
    );
  }
}
