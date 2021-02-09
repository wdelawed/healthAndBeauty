import 'dart:ui';

import 'package:HealthAndBeauty/components/ui/components_screen.dart';
import 'package:HealthAndBeauty/prescriptions/ui/prescriptions_page.dart';
import 'package:HealthAndBeauty/widgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customers/ui/customers_screen.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CustomersScreen customersScreen ;
  ComponentsScreen componentsScreen;
  PrescriptionsPage prescriptionsPage;
  _HomePageState() {
    this.customersScreen =  CustomersScreen(); 
    this.componentsScreen = ComponentsScreen(); 
    this.prescriptionsPage = PrescriptionsPage();
    }
  int _selected = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: IndexedStack(
              index: _selected,
              children: <Widget>[
                componentsScreen,
                customersScreen,
                
                prescriptionsPage
              ],
            ),
          ),
          ClipRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: CustomAppBar())
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: 375,
        height: 85,
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          elevation: 0,
          selectedItemColor: Color(0xff6170FC),
          iconSize: 24,
          onTap: (i) {
            if (i != _selected)
              setState(() {
                _selected = i;
              });
          },
          currentIndex: _selected,
          items: [
            BottomNavigationBarItem(
              title: Text(
                "Customers",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              icon: Image.asset("assets/icons/customers.png"),
              activeIcon: Image.asset("assets/icons/customers.png",
                  width: 29,
                  height: 20,
                  fit: BoxFit.cover,
                  color: Color(0xff5160FF)),
            ),
            BottomNavigationBarItem(
              title: Text(
                "Home",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              icon: Image.asset("assets/icons/ic_home.png"),
              activeIcon: Image.asset("assets/icons/home_active.png"),
            ),
            BottomNavigationBarItem(
              title: Text(
                "Prescriptions",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              icon: Image.asset("assets/icons/prescriptions.png"),
              activeIcon: Image.asset("assets/icons/prescriptions_active.png"),
            ),
          ],
        ),
      ),
    );
  }
}
