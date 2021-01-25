import 'package:HealthAndBeauty/customers/bloc/customers_bloc.dart';
import 'package:HealthAndBeauty/customers/events/customers_events.dart';
import 'package:HealthAndBeauty/customers/states/customers_states.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:HealthAndBeauty/widgets/customer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomersScreen extends StatelessWidget {
  final CustomersBloc _bloc = CustomersBloc(Repository());
  @override
  Widget build(BuildContext context) {
    _bloc.add(CustomersIntitEvent());
    return BlocProvider<CustomersBloc>(
      create: (_) => _bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [_buildBody(context)],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<CustomersBloc, CustomerState>(
        builder: (context, CustomerState state) {
      if (state is CustomersLoadedState) {
        List<Customer> customers = List<Customer>.from(state.customers);
        if (customers.isEmpty) {
          return Expanded(
              child: Container(
                  child: Center(
            child: Text("you don't have any Customers\nPlease add Customers "),
          )));
        } else {
          customers.insert(0, Customer());
          return Expanded(
            child: ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (context, pos) {
                    if (pos == 0) {
                      return Container(
                        margin: EdgeInsets.only(top: 100),
                        height: 116,
                        child: Container(
                          padding: EdgeInsets.only(left: 29),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Customers",
                                style: TextStyle(
                                    color: Color(0xff464646),
                                    fontSize: 36,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "you have ${customers.length - 1}+ customers",
                                style: TextStyle(
                                    color: Color(0xffB2B2B2),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return CustomerWidget(customers[pos]);
                  },
            ),
          );
        }
      }
      if (state is CustomersErrorState) {
        return Expanded(
            child: Container(
                child: Center(
          child: Text("${state.error}"),
        )));
      }
      return Expanded(
          child: Container(child: Center(child: CircularProgressIndicator())));
    });
  }
}
