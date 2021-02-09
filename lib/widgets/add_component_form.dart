import 'dart:io';

import 'package:HealthAndBeauty/bloc/app_bloc.dart';
import 'package:HealthAndBeauty/components/bloc/add_component_bloc.dart';
import 'package:HealthAndBeauty/components/events/components_events.dart';
import 'package:HealthAndBeauty/components/states/components_state.dart';
import 'package:HealthAndBeauty/customers/bloc/add_customer_bloc.dart';
import 'package:HealthAndBeauty/customers/events/customers_events.dart';
import 'package:HealthAndBeauty/customers/states/customers_states.dart';
import 'package:HealthAndBeauty/helpers/custom_colors.dart';
import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/model/component.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddComponentForm extends StatefulWidget {
  @override
  _AddComponentFormState createState() => _AddComponentFormState();
}

class _AddComponentFormState extends State<AddComponentForm> {
  final _key = GlobalKey<FormState>();
  final Component _component = Component();

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
            margin: EdgeInsets.only(top: 22),
            width: 249,
            child: TextFormField(
              onSaved: (v) {
                _component.name = v;
              },
              validator: (v) {
                if (v.isEmpty) return "Component Name Can't be empty";
                if (v.length < 6)
                  return "Component Name must be 6 Chars at least";
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
                hintText: "Component Name",
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: UiColors.main.withOpacity(.5),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 16, right: 9),
                width: 150,
                child: TextFormField(
                  onSaved: (v) {
                    _component.quantity = int.parse(v).toString();
                  },
                  validator: (v) {
                    if (v.isEmpty) return "Component Quantity Can't be empty";
                    try {
                      int.parse(v);
                    } catch (FormatException) {
                      return "Component Quantity must be a number";
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
                    hintText: "Quantity",
                    hintStyle: TextStyle(
                        fontSize: 16,
                        color: UiColors.main.withOpacity(.5),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                width: 90,
                child: TextFormField(
                  onSaved: (v) {
                    _component.unit = v;
                  },
                  validator: (v) {
                    if (v.isEmpty) return "Unit Can't be empty";
                    return null;
                  },
                  keyboardType: TextInputType.text,
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
                    hintText: "Unit",
                    hintStyle: TextStyle(
                        fontSize: 16,
                        color: UiColors.main.withOpacity(.5),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 22),
            width: 249,
            child: TextFormField(
              onSaved: (v) {
                _component.price = int.parse(v);
              },
              validator: (v) {
                if (v.isEmpty) return "Component Price Can't be empty";
                try {
                  int.parse(v);
                } catch (FormatException) {
                  return "Component Price must be a number";
                }
                return null;
              },
              maxLength: 6,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                hintText: "Price",
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
            height: 41,
            child: TextFormField(
              onSaved: (v) {
                _component.expiry_date = Utils.toServerDate(v);
              },
              validator: (v) {
                return v.isEmpty ? "date can't be empty" : null;
              },
              readOnly: true,
              keyboardType: TextInputType.datetime,
              onTap: _pickDate,
              controller: dateController,
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff8834D0),
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.date_range,
                  color: Color(0xBD8834D0),
                  size: 18,
                ),
                filled: true,
                border: InputBorder.none,
                fillColor: Colors.white,
                hintText: "Expiry Date",
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: UiColors.main.withOpacity(.5),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          BlocConsumer<AddComponentBloc, ComponentState>(
            cubit: BlocProvider.of<AppBloc>(context).componentsBloc.addBloc,
            builder: (context, state) {
              if (state is AddComponentLoadingState) {
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
                      BlocProvider.of<AppBloc>(context)
                          .componentsBloc
                          .add(AddComponentEvent(_component, 0));
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                        Color(0xff6CBBF5),
                        Color(0xff5B139A)
                      ]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                    ),
                    child: Container(
                      constraints: const BoxConstraints(
                          minWidth: 88.0,
                          minHeight: 44.0), // min sizes for Material buttons
                      alignment: Alignment.center,
                      child: const Text(
                        'ADD Component',
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
              if (state is AddComponentSuccessState) {
                Fluttertoast.showToast(
                  msg: "Component added successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                );
                Navigator.pop(context);
              }
              if (state is AddComponentErrorState) {
                Fluttertoast.showToast(
                  msg: "Error adding customer: ${state.error}",
                  toastLength: Toast.LENGTH_LONG,
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
      child: Text(
        "$currentLength/$maxLength",
        style: TextStyle(
            color: isFocused ? UiColors.main : UiColors.textMain,
            fontSize: 11,
            fontWeight: isFocused ? FontWeight.w700 : FontWeight.w300),
      ),
    );
  }

  _pickDate() async {
    print("picking up date");
    DateTime now = DateTime.now();
    DateTime date = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 1),
        lastDate: DateTime(now.year + 5));

    DateTime d = DateTime(
        date.year, date.month, date.day, now.hour, now.minute, now.second);
    DateFormat format = DateFormat("MM-yyyy");

    dateController.text = format.format(d);
  }
}
