
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';

class AssignPrescriptionForm extends StatefulWidget{
  @override
  _AssignPrescriptionFormState createState() => _AssignPrescriptionFormState();
}

class _AssignPrescriptionFormState extends State<AssignPrescriptionForm> {

  final _key = GlobalKey<FormState>() ;

   int _presc_id ;
   int _customer_id ;
   final TextEditingController prescController = TextEditingController();
   final TextEditingController customersController = TextEditingController();
   final TextEditingController dateController = TextEditingController();
   List<Prescription> prescriptions ;
   List<Customer> customers ;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key, 
      child: Container(
        padding: EdgeInsets.only(top: 61, left: 31, right: 30),
        child: Column(
          children: [
            Container(
              width: 249,
              height: 41,
              child: TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: prescController,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff8834D0)),
                  decoration:InputDecoration(
                    suffixIcon: Icon(Icons.event_note, color: Color(0xBD8834D0), size: 18,),
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 16, color: Color(0xff8834D0), fontWeight: FontWeight.w500),
                    hintText: "Prescription Name",
                    fillColor: Colors.white, 
                    filled: true) 
                ),
                itemBuilder: _getItemBuilder, 
                onSuggestionSelected: _presSuggestionSelected, 
                suggestionsCallback: _getPrescSuggestions,

                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 22),
              width: 249,
              height: 41,
              child: TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: customersController,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff8834D0)),
                  decoration:InputDecoration(
                    suffixIcon: Icon(Icons.assignment_ind, color: Color(0xBD8834D0), size: 18,),
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 16, color: Color(0xff8834D0), fontWeight: FontWeight.w500),
                    hintText: "Customer Name",
                    fillColor: Colors.white, 
                    filled: true) 
                ),
                itemBuilder: _getItemBuilder, 
                onSuggestionSelected: _customerSuggestionSelected, 
                suggestionsCallback: _getCustomersSuggestions,

                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 22),
              width: 249,
              height: 41,
              child: TextFormField(
                  keyboardType: TextInputType.datetime,
                  onTap: _pickDate,
                  controller: dateController,
                  style: TextStyle(fontSize: 16, color: Color(0xff8834D0), fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.date_range, color: Color(0xBD8834D0), size: 18,),
                    filled: true,
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    hintText: "Prescription Date", 
                    hintStyle: TextStyle(fontSize: 16, color: Color(0xff8834D0), fontWeight: FontWeight.w500),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 22),
              width: 249,
              height: 143,
              child: TextFormField(
                  maxLines: 6,
                  style: TextStyle(fontSize: 16, color: Color(0xff8834D0), fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    hintText: "Notes", 
                    hintStyle: TextStyle(fontSize: 16, color: Color(0xff8834D0), fontWeight: FontWeight.w500),
                  ),
                ),
              ),

              Container(
              margin: EdgeInsets.only(top: 22),
              child: RaisedButton(
                onPressed: () { },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                padding: const EdgeInsets.all(0.0),
                child: Ink(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xff6CBBF5), Color(0xff5B139A)]),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 88.0, minHeight: 44.0), // min sizes for Material buttons
                    alignment: Alignment.center,
                    child: const Text(
                      'ADD PRESCRIPTION',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ),
            ),
          ]
        ),
      ),
    );
  }
  Widget _getItemBuilder(BuildContext context, dynamic item){
      return ListTile(
        title : Text(item.name, style: TextStyle(color: Color(0xBD8834D0), fontWeight: FontWeight.w500),),
      );
  }

  _presSuggestionSelected(Prescription suggestion){
      setState(() {
        if(suggestion.id > -1)
          _presc_id = suggestion.id ;
      });
      prescController.text = suggestion.name;
  }

   _customerSuggestionSelected(Customer suggestion){
      setState(() {
        if(suggestion.id > -1)
          _customer_id = suggestion.id ;
      });
      customersController.text = suggestion.name;
  }

  Future<List<Prescription>> _getPrescSuggestions(String keyword) async{
      Repository repository = Repository() ;
      
      try {
        if(prescriptions == null)
            prescriptions = await repository.getAllPrescriptions();
        return prescriptions.where((element) => element.name.toLowerCase().startsWith(keyword.toLowerCase())).toList() ;
      }
      catch(e){
        if(prescriptions == null){
          prescriptions = List<Prescription>() ;
        prescriptions.add(Prescription(name: e.toString(), id: -1));
        }  
        return prescriptions ;
      }
  }

  Future<List<Customer>> _getCustomersSuggestions(String keyword) async{
      Repository repository = Repository() ;
      
      try {
        if(customers == null)
            customers = await repository.getAllCustomers();
        return customers.where((element) => element.name.toLowerCase().startsWith(keyword.toLowerCase())).toList() ;
      }
      catch(e){
        if(customers == null){
          customers = List<Customer>() ;
        customers.add(Customer(name: e.toString(), id: -1));
        }
        return customers ;
      }
  }

  _pickDate() async{
    print("picking up date") ;
    DateTime now = DateTime.now() ;
    DateTime date = await showDatePicker(
      context: context, 
      initialDate: now, 
      firstDate: DateTime(now.year-3), 
      lastDate: DateTime(now.year+3)) ;

      DateTime d  = DateTime(date.year, date.month, date.day, now.hour, now.minute, now.second) ;
      DateFormat format = DateFormat("dd-MM-yyyy {} HH:mm:ss") ;

      dateController.text = format.format(d).replaceFirst("{}", "AT") ;
  }
}