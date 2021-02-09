import 'dart:math';

import 'package:HealthAndBeauty/helpers/custom_colors.dart';
import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/model/component.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:HealthAndBeauty/widgets/prescription_component_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          elevation: 0,
          floating: false,
          pinned:true,
          title: Text("${prescription.name}"),
          leading: FlatButton(
            child: Image(
              image: AssetImage("assets/icons/back_white.png"),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          expandedHeight: 352,
          flexibleSpace: FlexibleSpaceBar(
          
            stretchModes: <StretchMode>[StretchMode.blurBackground],
            background: Hero(
                tag: "Prescription$id",
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: 352,
                  child: CachedNetworkImage(
                    placeholder: (_, __) => Image(
                      image: CachedNetworkImageProvider(
                          "${Utils.imagesUrl}thumbnails/${prescription.presc_image}"),
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                    imageUrl: "${Utils.imagesUrl}${prescription.presc_image}",
                  ),
                )),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(_buildDelegates()),
        ),
      ],
    );
  }

  List<Widget> _buildDelegates() {
    List<Widget> delegates = [
      Container(
        height: 109,
        padding: EdgeInsets.only(left: 36, right: 36, top: 30),
        child: Text(
          "${prescription.name}",
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
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
              child: Text(
                "${prescription.price} SDG",
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
          style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w300,
              color: Color(0xffB7B7B7)),
        ),
      ),
      Container(
        width: 302,
        margin: EdgeInsets.only(top: 10, left: 36, right: 36),
        child: Text(
          "${prescription.notes}",
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
          style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w300,
              color: Color(0xffB7B7B7)),
        ),
      ),
    ];
    if (prescription.components == null)
      prescription.components = List<Component>();
    if (prescription.components.isNotEmpty) {
      int pos = 0;
      for (Component component in prescription.components) {
        delegates.add(PrescriptionComponentWidget(component, id: pos));
        pos += 1;
      }
    } else {
      delegates.add(Container(
        child: Center(child: Text("This Prescription has no Components")),
      ));
    }
    delegates.add(Container(
      height: max(0, 353 - prescription.components.length * 83.0),
    ));
    return delegates;
  }
}
