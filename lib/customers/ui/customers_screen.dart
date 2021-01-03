import 'package:HealthAndBeauty/customers/bloc/customers_bloc.dart';
import 'package:HealthAndBeauty/customers/states/customers_states.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/widgets/CustomAppBar.dart';
import 'package:HealthAndBeauty/widgets/customer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomersScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            _buildAppBar(context) , 
            _buildBody(context)
          ],
        ),);
        }
      
  Widget  _buildAppBar(BuildContext context) {
      return CustomAppBar();
    }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<CustomersBloc, CustomerState>(
      builder: (context, CustomerState state){
          if(state is CustomersLoadedState){
            List<Customer> customers = state.customers ;
            if(customers.isEmpty){
              return Expanded(child: Container(child: Center(child:Text("you don't have any Customers\nPlease add Customers "),)));
            }
            else {
              customers.insert(0, Customer()) ;
              return Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height-100,
                child: ListView.builder(itemCount: customers.length ,itemBuilder: (context, pos)  {
                  if(pos == 0 ){
                    return Container(
                      height: 116, 
                      child: Container(
                        padding: EdgeInsets.only(left:29),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Customers", style: TextStyle(color: Color(0xff464646), fontSize: 36, fontWeight: FontWeight.w500),) , 
                            Text("you have ${customers.length-1}+ customers", style: TextStyle(color: Color(0xffB2B2B2), fontSize:16, fontWeight:FontWeight.w500),),
                          ], 
                        ),
                      ),
                    );
                  }
                  return CustomerWidget(customers[pos]);
                } ),
              );
            }
          }
          if(state is CustomersErrorState) {
            return Expanded(child: Container(child: Center(child:Text("${state.error}"),)));
          }
          return Expanded(child: Container(child: Center(child: CircularProgressIndicator()))) ;
    }) ;
  }

}