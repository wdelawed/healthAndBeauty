

import 'package:HealthAndBeauty/customers/ui/customer_details_screen.dart';
import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomerWidget extends StatelessWidget{
  Customer customer; 
  CustomerWidget(this.customer) ; 
  @override
  Widget build(BuildContext context){

    return Container (
      margin: EdgeInsets.only(left:29, right: 21),
      height: 150,
      child: Row(
        children: [
          GestureDetector(
            onTap: (){_getCustomerDetails(context);},
            child: Hero(
              tag: "customer${customer.id}",
              child: Container(
                width: 105,
                height: 105,
                decoration: BoxDecoration(
                  color: Color(0xffE2E2E2),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                  
                    image: NetworkImage("${Utils.imagesUrl}${customer.before_img}", ),
                    fit: BoxFit.cover),
                  ) 
                ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left:23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160,
                  child: Text("${customer.name}", style: TextStyle(color: Color(0xff464646), fontSize: 20, fontWeight: FontWeight.w600),)) , 
                Container(
                  margin: EdgeInsets.only(top:20),
                  child: Text("${customer.age} Years old", style: TextStyle(color: Color(0xff464646), fontSize: 14, fontWeight: FontWeight.w400),)),
              ]
            ),
          )
        ],
      ),
      ) ;
  }

  void _getCustomerDetails(context) {
     Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CustomerDetailsScreen(customer)),
  );
  }
}