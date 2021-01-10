import 'package:HealthAndBeauty/bloc/customerBloc.dart';
import 'package:HealthAndBeauty/customers/events/customers_events.dart';
import 'package:HealthAndBeauty/customers/ui/customers_screen.dart';
import 'package:HealthAndBeauty/model/customer.dart';
import 'package:HealthAndBeauty/model/prescription.dart';
import 'package:HealthAndBeauty/persistence/respository.dart';
import 'package:HealthAndBeauty/prescriptions/ui/prescriptions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'customers/bloc/customers_bloc.dart';
import 'model/networkResponse.dart';

void main() {
  debugPaintSizeEnabled  = false ;
  runApp(MyApp(Repository()));
}

class MyApp extends StatelessWidget {
  final Repository _repository ; 
  CustomersBloc _customersBloc ;
  // This widget is the root of your application.

  MyApp(this._repository){
    this._customersBloc = CustomersBloc(_repository) ;
  }

  @override
  Widget build(BuildContext context) {
    _customersBloc.add(CustomersIntitEvent());
    return BlocProvider<CustomersBloc>(
      create: (context) => _customersBloc,
      child: MaterialApp(
      title: 'Health and Beauty',
      
      theme: ThemeData(
        fontFamily: "SfUi",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
      ),
      home: PrescriptionsPage(),
    ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    customerBloc.fetchCustomer(2) ;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder(stream: customerBloc.customer, builder: (context, AsyncSnapshot<NetworkResponse<Customer>> snapshot){
          if(snapshot.hasData)
          {
            NetworkResponse<Customer> data  = snapshot.data ;
            if(data.error == true ){
              return Text(data.msg) ;
            }
            else {
              if(data.data != null) {
                return _buildCustomer(data.data) ;
              }
              else 
                return Text("unknown customer") ;
            }
          }
          else if (snapshot.hasError){
            return Text(snapshot.error) ;
          }
          return CircularProgressIndicator() ;
        },),
      ),);
  }

  Widget _buildCustomer(Customer customer) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Customer Details:',
            ),
            Text(
              customer.name,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              customer.age.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              customer.notes,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ) ;
  }
}
