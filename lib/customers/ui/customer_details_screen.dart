import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:HealthAndBeauty/widgets/CustomAppBar.dart';
import 'package:HealthAndBeauty/widgets/custom_fab.dart';
import 'package:HealthAndBeauty/widgets/prescription_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerDetailsScreen extends StatelessWidget{
  Customer customer ;
  CustomerDetailsScreen(this.customer) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildAppBar() ,
            _buildBody(),
            ],
          ),
        ),
        floatingActionButton: CustomFab(),
      ) ;
    }
  
  Widget _buildAppBar() {
        return CustomAppBar(leading: AssetImage("assets/icons/back.png"), title: "", back: true,) ;
    }
            
  Widget _buildBody() {
        return Expanded(
          child: Column(
          children : [
            Container(
              padding: EdgeInsets.only(left:28, right:29),
              height: 84,
              child: Row(
                children: [
                  Hero(
                    tag: "customer${customer.id}",
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: Color(0xffE2E2E2),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage("http://192.168.44.103:8000/images/${customer.before_img}", ),
                          fit: BoxFit.cover),
                        ) 
                      ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left:23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 149,
                          child: Text(customer.name, style: TextStyle(color: Color(0xff464646), fontSize: 24, fontWeight: FontWeight.w500),)) , 
                        Container(
                          margin: EdgeInsets.only(top:4),
                          child: Text("${customer.age} Years old", style: TextStyle(color: Color(0xff464646), fontSize: 13, fontWeight: FontWeight.w400),)),
                      ]
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 266,
              margin: EdgeInsets.only(top:18),
              child: Row(
                children:[
                  Column(
                    children: [
                      Text("25", style: TextStyle(fontSize: 20, color: Color(0xff454F63), fontWeight: FontWeight.w500)), 
                      Text("YEARS", style: TextStyle(fontSize: 11, color: Color(0xff78849E), fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 38, right: 15),
                    height: 40,
                    child: VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: Color(0xffF4F4F6),
                    ),
                  )
                  ,
                  Column(
                    children: [
                      Text("30", style: TextStyle(fontSize: 20, color: Color(0xff454F63), fontWeight: FontWeight.w500)), 
                      Text("PRESCRIPTIONS", style: TextStyle(fontSize: 11, color: Color(0xff78849E), fontWeight: FontWeight.w500)),
            
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 28),
                    height: 40,
                    child: VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: Color(0xffF4F4F6),
                    ),
                  )
                  ,
                  Column(
                    children: [
                      Text("3", style: TextStyle(fontSize: 20, color: Color(0xff454F63), fontWeight: FontWeight.w500)), 
                      Text("MONTHS", style: TextStyle(fontSize: 11, color: Color(0xff78849E), fontWeight: FontWeight.w500)),
                    ],
                  ),
                ]
              ),
            ),
            Container(
              margin: EdgeInsets.only(left:29, right: 29, top: 22),
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
                      'UPDATE PHOTO',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top:15, bottom:27, left:29),
              child: Text(
                "All Prescriptions" ,
                style: TextStyle(fontSize: 19, color: Color(0xffB2B2B2), fontWeight: FontWeight.w400),
              ),
            ),
            _buildCustomerPrescriptions(),
          ],
        )) ;
    }
  Widget _buildCustomerPrescriptions(){
    if(customer.prescriptions.length > 0 ){
      return Expanded(
        child: Container(
          child: ListView.builder(
            itemCount: customer.prescriptions.length,
            itemBuilder: (context, pos){
            return PrescriptionWidget(customer.prescriptions[pos], id : pos) ;
          }),
        ),
      ) ;
    }
    else 
      return Expanded(child: Center(child: Text("this customer has no Supscriptions"),)) ;
  }
}