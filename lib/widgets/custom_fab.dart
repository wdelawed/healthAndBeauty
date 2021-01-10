import 'package:flutter/material.dart';

class CustomFab extends FloatingActionButton {
  final Function _onPressed ;
  CustomFab(this._onPressed) ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: Container(
        child: Image(image: AssetImage("assets/icons/plus.png")),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xff6CBBF5), Color(0xff5B139A)]),
           shape: BoxShape.circle),
      ),
    );
  }
}