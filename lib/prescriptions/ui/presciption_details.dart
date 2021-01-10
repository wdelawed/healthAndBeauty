import 'package:HealthAndBeauty/helpers/custom_colors.dart';
import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrescriptionDetails extends StatelessWidget {
  final Prescription prescription;
  final int id;
  PrescriptionDetails(this.prescription, {this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: FlatButton(
            child: Image(
              image: AssetImage("assets/icons/back_white.png"),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          expandedHeight: 352,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: "Prescription$id",
              child: Image(
                image: NetworkImage(
                    "${Utils.imagesUrl}${prescription.presc_image}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              height: 109,
              padding: EdgeInsets.only(left: 36, right: 36, top: 30),
              child: Text(
                "Advanced Body-Care Kit",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: UiColors.textMain),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 36, right: 36, top: 14),
              child: RaisedButton(
                onPressed: () {},
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
                      '500 SDG',
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
            Container(
              margin: EdgeInsets.only(top: 17, left: 36),
              child: Text(
                "Details",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w300, color: Color(0xffB7B7B7)),
              ),
            ),
            Container(
              width: 302,
              height: 170,
              margin: EdgeInsets.only(top: 10, left: 36, right: 36),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting.",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: UiColors.textMain,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.0,
                    fontFamily: "Arial",
                    height: 1.8),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 17, left: 36, bottom: 17),
              child: Text(
                "Components",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w300, color: Color(0xffB7B7B7)),
              ),
            ),
          ],),
        ),
      ],
    );
  }
}
