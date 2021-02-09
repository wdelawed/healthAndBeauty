import 'package:HealthAndBeauty/bloc/app_bloc.dart';
import 'package:HealthAndBeauty/customers/bloc/add_customer_bloc.dart';
import 'package:HealthAndBeauty/customers/bloc/customers_bloc.dart';
import 'package:HealthAndBeauty/customers/bloc/delete_customer_bloc.dart';
import 'package:HealthAndBeauty/customers/events/customers_events.dart';
import 'package:HealthAndBeauty/customers/states/customers_states.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/widgets/add_customer_dialog.dart';
import 'package:HealthAndBeauty/widgets/custom_fab.dart';
import 'package:HealthAndBeauty/widgets/customer_widget.dart';
import 'package:HealthAndBeauty/widgets/page_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomersScreen extends StatefulWidget {
  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  List<Customer> customers = List<Customer>();
  LabeledGlobalKey<SliverAnimatedListState> _listKey =
      LabeledGlobalKey<SliverAnimatedListState>("customers list");

  SliverAnimatedList sliverAnimatedList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context),
      floatingActionButton: CustomFab(
        () {
          BlocProvider.of<AppBloc>(context)
              .customersBloc
              .add(AddCustomerStartedEvent());
          Navigator.push(
            context,
            AppPageRoute(
              builder: (context) {
                return AddCustomerDialog();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddCustomerBloc, CustomerState>(
          cubit: BlocProvider.of<AppBloc>(context).customersBloc.addBloc,
          listener: (context, state) {
            if (state is AddCustomerSuccessState) {
              this.customers.insert(state.index, state.customer);
              _listKey.currentState.insertItem(state.index);
            } else if (state is AddCustomerErrorState) {
              Fluttertoast.showToast(
                msg: "Error: ${state.error}",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
              );
            }
          },
        ),
        BlocListener<DeleteCustomerBloc, CustomerState>(
          cubit: BlocProvider.of<AppBloc>(context).customersBloc.deleteBloc,
          listener: (context, state) {
            if (state is DeleteCustomerErrorState) {
              Fluttertoast.showToast(
                msg: "Error: ${state.error}",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
              );
              this.customers.insert(state.index, state.customer);
              _listKey.currentState.insertItem(state.index);
            } else if (state is DeleteCustomerSuccessState) {
              //handle deletion success logic here
              Fluttertoast.showToast(
                msg: "Deleted Succsessfully",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
              );
            } else if (state is DeleteCustomerLoadingState) {
              this.customers.removeAt(state.index);
              _listKey.currentState
                  .removeItem(state.index, (context, animation) => Container());
            }
          },
        ),
      ],
      child: BlocBuilder<CustomersBloc, CustomerState>(
          cubit: BlocProvider.of<AppBloc>(context).customersBloc,
          builder: (context, CustomerState state) {
            if (state is GetCustomersSuccessState) {
              return _buildList(state.customers);
            }
            if (state is GetCustomersErrorState) {
              return Container(
                child: Center(
                  child: Text("${state.error}"),
                ),
              );
            }
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              ),
            );
          }),
    );
  }

  Widget _buildList(_customers) {
    if (_customers.isEmpty) {
      return Container(
        child: Center(
          child: Text("you don't have any Customers\nPlease add Customers "),
        ),
      );
    } else {
      return CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            expandedHeight: 216,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
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
                        "you have ${_customers.length} customers",
                        style: TextStyle(
                            color: Color(0xffB2B2B2),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverAnimatedList(
            key: _listKey,
            itemBuilder: (context, index, animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset(0, 0),
                ).animate(animation),
                child: CustomerWidget(customers[index], index),
              );
            },
          ),
        ],
      );
    }
  }
}
