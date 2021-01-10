import 'package:HealthAndBeauty/customers/ui/customer_details_screen.dart';
import 'package:HealthAndBeauty/helpers/custom_colors.dart';
import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:HealthAndBeauty/prescriptions/ui/presciption_details.dart';
import 'package:flutter/material.dart';

class PrescriptionItem extends StatelessWidget {
  final Prescription _prescription;
  final int id;
  PrescriptionItem(this._prescription, this.id);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      padding: EdgeInsets.only(left: 29, right: 29, bottom: 31),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 200),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return PrescriptionDetails(_prescription,id: id);
                  },
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return Align(
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                ),
              );
            },
            child: Hero(
              tag: "Prescription${id}",
              child: Container(
                width: 101,
                height: 118,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "${Utils.imagesUrl}${_prescription.presc_image}"),
                        fit: BoxFit.cover),
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(6)),
              ),
            ),
          ),
          Container(
            height: 82,
            margin: EdgeInsets.only(left: 26, top: 16, bottom: 21),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 171,
                    child:
                        Text("${_prescription.name}", style: UiColors.title)),
                Container(
                    width: 171,
                    alignment: Alignment.topLeft,
                    child: Text(
                      "sold ${_prescription.customers} times",
                      textAlign: TextAlign.start,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
