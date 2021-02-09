import 'package:HealthAndBeauty/customers/bloc/update_customer_image_bloc.dart';
import 'package:HealthAndBeauty/customers/events/customers_events.dart';
import 'package:HealthAndBeauty/customers/states/customers_states.dart';
import 'package:HealthAndBeauty/helpers/custom_colors.dart';
import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/widgets/assign_prescription_dialog.dart';
import 'package:HealthAndBeauty/widgets/custom_fab.dart';
import 'package:HealthAndBeauty/widgets/customer_images_viewer.dart';
import 'package:HealthAndBeauty/widgets/customer_prescriptions_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final Customer customer;
  final int index;
  final UpdateCustomerImageBloc _bloc;
  CustomerDetailsScreen(this.customer, this.index, this._bloc);

  @override
  _CustomerDetailsScreenState createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    widget._bloc.add(UpdateCustomerImageStartedEvent());
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(),
      floatingActionButton: CustomFab(() {
        showDialog(
            context: context,
            builder: (context) {
              return AssignPrescDialog();
            });
      }),
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          
          leading: Container(
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: UiColors.textMain,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          elevation: 0,
          pinned: true,
          backgroundColor: Colors.white,
          expandedHeight: 355,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            stretchModes: [
              StretchMode.blurBackground
            ],
            background: Container(
              margin: EdgeInsets.only(top: 100),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 28, right: 29),
                    height: 84,
                    child: Row(
                      children: [
                        Hero(
                          tag: "customer${widget.customer.id}",
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) {
                                    return CustomerImagesViewer(
                                        widget.customer);
                                  },
                                ),
                              );
                            },
                            child: Container(
                              width: 84,
                              height: 84,
                              decoration: BoxDecoration(
                                color: Color(0xffE2E2E2),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      "${Utils.imagesUrl}thumbnails/customers/${widget.customer.before_img}",
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 23),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 149,
                                  child: Text(
                                    "${widget.customer.name.length > 15 ? widget.customer.name.substring(0, 14) : widget.customer.name}....",
                                    style: TextStyle(
                                        color: Color(0xff464646),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 4),
                                  child: Text(
                                    "${widget.customer.diagnosis}",
                                    style: TextStyle(
                                        color: Color(0xff464646),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 266,
                    margin: EdgeInsets.only(top: 18),
                    child: Row(children: [
                      Column(
                        children: [
                          Text(
                            "${widget.customer.age}",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff454F63),
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "YEARS",
                            style: TextStyle(
                                fontSize: 11,
                                color: Color(0xff78849E),
                                fontWeight: FontWeight.w500),
                          ),
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
                      ),
                      Column(
                        children: [
                          Text(
                            "${widget.customer.prescriptions.length}",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff454F63),
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "PRESCRIPTIONS",
                            style: TextStyle(
                                fontSize: 11,
                                color: Color(0xff78849E),
                                fontWeight: FontWeight.w500),
                          ),
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
                      ),
                      Column(
                        children: [
                          Text(
                            "${widget.customer.since[0]}",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff454F63),
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${widget.customer.since[1]}",
                            style: TextStyle(
                                fontSize: 11,
                                color: Color(0xff78849E),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  BlocConsumer<UpdateCustomerImageBloc, CustomerState>(
                    cubit: widget._bloc,
                    listener: (context, state) {
                      if (state is UpdateCustomerImageSuccessState) {
                        widget.customer.after_img = state.customer.after_img;
                        Fluttertoast.showToast(
                            msg: "Customer Image Updated Successfully",
                            toastLength: Toast.LENGTH_LONG);
                      } else if (state is UpdateCustomerImageErrorState) {
                        Fluttertoast.showToast(
                            msg:
                                "Error Updating Customer Image: ${state.error}",
                            toastLength: Toast.LENGTH_LONG);
                      }
                    },
                    builder: (context, state) {
                      if (state is UpdateCustomerImageLoadingState) {
                        return Container(
                          margin: EdgeInsets.only(left: 29, right: 29, top: 22),
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: UiColors.main,
                            ),
                          ),
                        );
                      }
                      return Container(
                        margin: EdgeInsets.only(left: 29, right: 29, top: 22),
                        child: RaisedButton(
                          onPressed: () async {
                            showSelectSourceBottomSheet();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          padding: const EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xff6CBBF5),
                                Color(0xff5B139A)
                              ]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 88.0,
                                  minHeight:
                                      44.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: const Text(
                                'UPDATE PHOTO',
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
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 15, bottom: 27, left: 29),
                    child: Text(
                      "All Prescriptions",
                      style: TextStyle(
                          fontSize: 19,
                          color: Color(0xffB2B2B2),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _buildCustomerPrescriptions(),
      ],
    );
  }

  showSelectSourceBottomSheet() async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 120,
            color: Colors.grey.withOpacity(.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      CupertinoIcons.camera,
                      color: UiColors.textMain,
                    ),
                    title: Text("Camera"),
                    onTap: () async {
                      Navigator.pop(context);
                      PickedFile file = await ImagePicker()
                          .getImage(source: ImageSource.camera);
                      if (file != null) {
                        String image = file.path;
                        widget._bloc.add(UpdateCustomerImageEvent(
                            widget.customer.id, image, widget.index));
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.image_outlined,
                      color: UiColors.textMain,
                    ),
                    title: Text("Gallery"),
                    onTap: () async {
                      Navigator.pop(context);
                      PickedFile file = await ImagePicker()
                          .getImage(source: ImageSource.gallery);
                      if (file != null) {
                        String image = file.path;
                        widget._bloc.add(UpdateCustomerImageEvent(
                            widget.customer.id, image, widget.index));
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _buildCustomerPrescriptions() {
    if (widget.customer.prescriptions.length > 0) {
      return Container(
        
        child: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, pos) {
              return PrescriptionWidget(widget.customer.prescriptions[pos],
                  id: pos);
            },
            childCount: widget.customer.prescriptions.length,
          ),
        ),
      );
    } else
      return SliverToBoxAdapter(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Text("this customer has no Supscriptions"),
          ),
        ),
      );
  }
}
