 import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrescriptionWidget extends StatelessWidget {
  Prescription prescription ;
  int id ;
  PrescriptionWidget(this.prescription, {this.id}) {
    if (id == null)
      id = 0 ; 

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 82,
      margin: EdgeInsets.symmetric(horizontal:29),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              border:Border.all(
                width: 1 , 
                color: Color(0x80464646)
              ),
              borderRadius: BorderRadius.all(Radius.circular(34))
              ),
            child: Text(
              "0$id",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color:Color(0x80464646)),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left:17),
            width: 172,
            child: Text(
              "${prescription.name}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color:Color(0xff464646)),),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(left:4),
              child: Text(_formatDate(prescription.pivot.created_at), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color:Color(0xff5B139A)),),
            )
          )
        ]
      ),
    );
  }

  String _formatDate(String dateString) {
    DateFormat outputFormat = DateFormat("dd-MM\nyyyy") ;
    dynamic s = dateString.split("T")[0].split("-") ;
    DateTime d = DateTime(int.parse(s[0]), int.parse(s[1]), int.parse(s[2])) ;
    return outputFormat.format(d) ;
  }
}