import 'dart:io';

import 'package:HealthAndBeauty/bloc/app_bloc.dart';
import 'package:HealthAndBeauty/customers/bloc/add_customer_bloc.dart';
import 'package:HealthAndBeauty/customers/events/customers_events.dart';
import 'package:HealthAndBeauty/customers/states/customers_states.dart';
import 'package:HealthAndBeauty/helpers/custom_colors.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddCustomerForm extends StatefulWidget {
  @override
  _AddCustomerFormState createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
  final ImagePicker _imagePicker = ImagePicker();
  final _key = GlobalKey<FormState>();
  final Customer _customer = Customer();
  String _customerImage = "";

  final TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Container(
        padding: EdgeInsets.only(top: 30, left: 31, right: 30),
        child: Column(children: [
          Container(
            width: 120,
            height: 120,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: UiColors.navIconsFill,
                    image: _customerImage.isNotEmpty
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(_customerImage), scale: .5),
                          )
                        : null,
                  ),
                ),
                Container(
                  width: 120,
                  height: 120,
                  alignment: Alignment(.6, .6),
                  child: Container(
                    width: 29,
                    height: 29,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: ClipPath(
                      clipBehavior: Clip.antiAlias,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () async {
                          PickedFile file = await _imagePicker.getImage(
                              source: ImageSource.gallery);
                          if (file != null) {
                            setState(() {
                              _customerImage = file.path;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          width: 29,
                          height: 29,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff716E6E).withOpacity(.90),
                          ),
                          child: SvgPicture.asset(
                            "assets/svgs/camera.svg",
                            width: 16.5,
                            height: 12.5,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 22),
            width: 249,
            child: TextFormField(
              onSaved: (v) {
                _customer.name = v;
              },
              validator: (v) {
                if (v.isEmpty) return "Customer Name Can't be empty";
                if (v.length < 6) return "Customer Name must be 6 Chars at least";
                return null;
              },
              maxLength: 15,
              buildCounter: _buildCounter,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff8834D0),
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                filled: true,
                border: InputBorder.none,
                fillColor: Colors.white,
                hintText: "Customer Name",
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: UiColors.main.withOpacity(.5),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            width: 249,
            child: TextFormField(
              onSaved: (v) {
                _customer.age = int.parse(v);
              },
              validator: (v) {
                if (v.isEmpty) return "Customer Age Can't be empty";
                try {
                  int.parse(v);
                } catch (FormatException) {
                  return "Customer Age must be a number";
                }
                return null;
              },
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLength: 4,
              buildCounter: _buildCounter,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff8834D0),
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                filled: true,
                border: InputBorder.none,
                fillColor: Colors.white,
                hintText: "Customer Age",
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: UiColors.main.withOpacity(.5),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 22),
            width: 249,
            child: TextFormField(
              onSaved: (v) {
                _customer.diagnosis = v;
              },
              validator: (v) {
                if (v.isEmpty) return "Diagnosis Can't be empty";
                if (v.length < 6) return "Diagnosis must be 6 Chars at least";
                return null;
              },
              maxLength: 21,
              buildCounter: _buildCounter,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff8834D0),
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                filled: true,
                border: InputBorder.none,
                fillColor: Colors.white,
                hintText: "Diagnosis",
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: UiColors.main.withOpacity(.5),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 36),
            width: 249,
            height: 143,
            child: TextFormField(
              onSaved: (v) {
                _customer.notes = v;
              },
              validator: (v) {
                if (v.isEmpty) return "Notes Can't be empty";
                if (v.length < 20) {
                  return "must be a 20 chars at least";
                }
                return null;
              },
              maxLength: 150,
              buildCounter: _buildCounter,
              maxLines: 6,
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff8834D0),
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                filled: true,
                border: InputBorder.none,
                fillColor: Colors.white,
                hintText: "Notes ",
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: UiColors.main.withOpacity(.5),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          BlocConsumer<AddCustomerBloc, CustomerState>(
            cubit: BlocProvider.of<AppBloc>(context).customersBloc.addBloc,
            builder: (context, state) {
              if (state is AddCustomerLoadingState) {
                return Container(
                  margin: EdgeInsets.only(top: 22, bottom: 46),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: UiColors.main,
                    ),
                  ),
                );
              }

              return Container(
                margin: EdgeInsets.only(top: 22, bottom: 46),
                child: RaisedButton(
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      _key.currentState.save();
                      if (_customerImage.isNotEmpty)
                        _customer.before_img = _customerImage;
                      if (_customerImage.isEmpty) {
                        Fluttertoast.showToast(
                          toastLength: Toast.LENGTH_SHORT,
                          msg: "please select customer image",
                        );
                        return ;
                      }
                      BlocProvider.of<AppBloc>(context)
                          .customersBloc
                          .add(AddCustomerEvent(_customer, 0));
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff6CBBF5), Color(0xff5B139A)]),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Container(
                      constraints: const BoxConstraints(
                          minWidth: 88.0,
                          minHeight: 44.0), // min sizes for Material buttons
                      alignment: Alignment.center,
                      child: const Text(
                        'ADD Customer',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              );
            },
            listener: (context, state) {
              if (state is AddCustomerSuccessState) {
                Fluttertoast.showToast(
                  msg: "Customer added successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                );
                Navigator.pop(context);
              }
              if (state is AddCustomerErrorState) {
                Fluttertoast.showToast(
                  msg: "Error adding customer: ${state.error}",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                );
              }
            },
          ),
        ]),
      ),
    );
  }

  Widget _buildCounter(BuildContext context,
      {int currentLength, bool isFocused, int maxLength}) {
    return Container(
      child: Text("$currentLength/$maxLength",
          style: TextStyle(
              color: isFocused ? UiColors.main : UiColors.textMain,
              fontSize: 11,
              fontWeight: isFocused ? FontWeight.w700 : FontWeight.w300)),
    );
  }
}
