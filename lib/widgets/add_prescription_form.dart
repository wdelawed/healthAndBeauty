import 'dart:io';

import 'package:HealthAndBeauty/helpers/custom_colors.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddPrescriptionForm extends StatefulWidget {
  @override
  _AddPrescriptionFormState createState() => _AddPrescriptionFormState();
}

class _AddPrescriptionFormState extends State<AddPrescriptionForm> {

  final ImagePicker _imagePicker = ImagePicker();
  final _key = GlobalKey<FormState>();
  final Prescription _prescription = Prescription();
  String _pres_image = "" ;


  final TextEditingController prescController = TextEditingController();
  final TextEditingController customersController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  List<Prescription> prescriptions;
  List<Customer> customers;

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
                  width:120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: UiColors.navIconsFill,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(File(_pres_image), scale: .5)
                    )
                  ),
                ),
                Container(
                  width: 120,
                  height: 120,
                  alignment: Alignment(.6,.6),
                  child: Container(
                    width: 29,
                    height: 29,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: ClipPath(
                      clipBehavior: Clip.antiAlias,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () async{
                         PickedFile file =  await _imagePicker.getImage(source: ImageSource.gallery) ;
                         if(file != null){
                           setState(() {
                                _pres_image = file.path ;
                           });
                        }},
                        child: Container(
                          padding: EdgeInsets.all(6),
                          width: 29,
                          height: 29,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff716E6E).withOpacity(.90),
                          ),
                          child: SvgPicture.asset("assets/svgs/camera.svg", width:16.5, height: 12.5, fit: BoxFit.contain,),
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
              onSaved:(v){_prescription.name = v;},
              validator: (v){
                if(v.isEmpty)
                  return "Prescription Name Can't be empty" ;
                if(v.length < 21)
                  return "Prescription Name must be 21 Chars" ;
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
                hintText: "Prescription Name",
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
              onSaved:(v){_prescription.price = int.parse(v);},
              validator: (v){
                if(v.isEmpty)
                  return "Prescription Price Can't be empty" ;
                try{
                  double.parse(v);
                }
                catch(FormatException){
                  return "Prescription Price must be a number";
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
                suffixIcon: Container(
                    padding: EdgeInsets.only(right: 10),
                    child:
                        Image(image: AssetImage("assets/icons/sdg_tag.png"))),
                suffixIconConstraints:
                    BoxConstraints(maxHeight: 21, maxWidth: 40),
                filled: true,
                border: InputBorder.none,
                fillColor: Colors.white,
                hintText: "Prescription Price",
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
              onSaved:(v){_prescription.creation_date = v;},
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
                hintText: "Prescription Date",
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
              onSaved:(v){_prescription.notes = v;},
              validator: (v){
                if(v.isEmpty)
                  return "Prescription Details Can't be empty" ;
                if(v.length < 150){
                  return "must be a 150 chars at least";
                }
                return null;
              },
              maxLength: 333,
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
                hintText: "Prescription Description",
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: UiColors.main.withOpacity(.5),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 22, bottom: 46),
            child: RaisedButton(
              onPressed: () {
                if(_key.currentState.validate()){
                     _key.currentState.save();
                     if(_pres_image.isNotEmpty)
                       _prescription.presc_image = _pres_image;
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
                    'ADD PRESCRIPTION',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildCounter(BuildContext context,
      {int currentLength, bool isFocused, int maxLength}) {
    return Container(
      child: Text("$currentLength/$maxLength", style: TextStyle(color: isFocused? UiColors.main: UiColors.textMain, fontSize: 11,  fontWeight: isFocused? FontWeight.w700 : FontWeight.w300)),
    );
  }


  _pickDate() async {
    print("picking up date");
    DateTime now = DateTime.now();
    DateTime date = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 3),
        lastDate: DateTime(now.year + 3));

    DateTime d = DateTime(
        date.year, date.month, date.day, now.hour, now.minute, now.second);
    DateFormat format = DateFormat("dd-MM-yyyy {} HH:mm:ss");

    dateController.text = format.format(d).replaceFirst("{}", "AT");
  }
}
