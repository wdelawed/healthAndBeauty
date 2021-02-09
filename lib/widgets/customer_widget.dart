import 'package:HealthAndBeauty/bloc/app_bloc.dart';
import 'package:HealthAndBeauty/customers/events/customers_events.dart';
import 'package:HealthAndBeauty/customers/ui/customer_details_screen.dart';
import 'package:HealthAndBeauty/helpers/uitilities.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/widgets/page_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomerWidget extends StatelessWidget {
  final Customer customer;
  final int index;
  CustomerWidget(this.customer, this.index);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: Dismissible(
        onDismissed: (_) {
          BlocProvider.of<AppBloc>(context)
              .customersBloc
              .add(DeleteCustomerEvent(customer, index));
        },
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
        key: UniqueKey(),
        child: Container(
          margin: EdgeInsets.only(left: 29, right: 21),
          
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  _getCustomerDetails(context);
                },
                child: Hero(
                  tag: "customer${customer.id}",
                  child: Container(
                    width: 105,
                    height: 105,
                    decoration: BoxDecoration(
                      color: Color(0xffE2E2E2),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          "${Utils.imagesUrl}thumbnails/customers/${customer.before_img}",
                        ),
                        fit: BoxFit.cover,
                      ),
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
                      width: 160,
                      child: Text(
                        "${customer.name}",
                        style: TextStyle(
                            color: Color(0xff464646),
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "${customer.age} Years old",
                        style: TextStyle(
                            color: Color(0xff464646),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getCustomerDetails(context) {
    Navigator.push(
      context,
      AppPageRoute(
          builder: (context) => CustomerDetailsScreen(customer, index,
              BlocProvider.of<AppBloc>(context).customersBloc.updateBloc)),
    );
  }
}
