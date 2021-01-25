import 'package:HealthAndBeauty/helpers/custom_colors.dart';
import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:HealthAndBeauty/prescriptions/ui/presciption_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrescriptionItem extends StatelessWidget {
  final Prescription _prescription;
  final int id;
  PrescriptionItem(this._prescription, this.id);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 31),
      child: Container(
        child: Dismissible(
          secondaryBackground: Container(
            alignment: AlignmentDirectional.centerEnd,
            color: Colors.redAccent,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 32.0, 0.0),
              child: SvgPicture.asset(
                "assets/svgs/trash.svg",
                color: Colors.white,
                width: 24,
                height: 24,
              ),
            ),
          ),
          background: Container(
            alignment: AlignmentDirectional.centerStart,
            color: Colors.redAccent,
            child: Padding(
              padding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
              child: SvgPicture.asset(
                "assets/svgs/trash.svg",
                color: Colors.white,
                width: 24,
                height: 24,
              ),
            ),
          ),
          key: Key(_prescription.id.toString()),
          child: Container(
            padding: EdgeInsets.only(left: 29, right: 29),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PrescriptionDetails(_prescription, id: id),
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
                            onError: (_, __) {
                              print("error loading image");
                            },
                            image: CachedNetworkImageProvider(
              
                                "${Utils.imagesUrl}${_prescription.presc_image}",
                                scale: 0.25,
                                ),
                            fit: BoxFit.cover),
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(6),
                      ),
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
                          child: Text("${_prescription.name}",
                              style: UiColors.title)),
                      Container(
                        width: 171,
                        alignment: Alignment.topLeft,
                        child: Text(
                          "sold ${_prescription.customers} times",
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
